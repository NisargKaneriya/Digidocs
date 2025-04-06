import 'package:digidocs/utils/download_image.dart';
import 'package:digidocs/utils/download_pdf.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:digidocs/global.dart';
import 'package:digidocs/services/document_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Univerisitymarksheet extends StatefulWidget {
  final String section;
  const Univerisitymarksheet({Key? key, required this.section}) : super(key: key);

  @override
  State<Univerisitymarksheet> createState() => _UniverisitymarksheetState();
}

class _UniverisitymarksheetState extends State<Univerisitymarksheet> {
  List<Map<String, dynamic>> documents = []; // Stores image URLs and dates
  bool isLoading = true;
  final DocumentService documentService = DocumentService();

  @override
  void initState() {
    super.initState();
    fetchDocuments();
  }

  Future<void> fetchDocuments() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("❌ User not logged in");
        return;
      }

      String userId = user.uid;
      final sectionKey = "univerisitymarksheet"; // Manually set section name for now

      // Log API request URL
      String apiUrl = "http://10.0.2.2:3000/api/documents/list?userId=$userId&section=$sectionKey";
      print("🛠️ Fetching from: $apiUrl");

      final response = await http.get(Uri.parse(apiUrl));

      print("📩 API Response Code: ${response.statusCode}");
      print("📩 API Response Body: ${response.body}");

      if (response.statusCode != 200) {
        print("❌ API Error: ${response.statusCode} - ${response.body}");
        return;
      }

      final responseData = jsonDecode(response.body);

      if (!responseData.containsKey("images") || responseData["images"].isEmpty) {
        print("ℹ️ No documents found for section: $sectionKey");
        return;
      }

      List<dynamic>? imagesList = responseData["images"][sectionKey];

      if (imagesList == null || imagesList.isEmpty) {
        print("ℹ️ No images found for section: $sectionKey");
        return;
      }

      print("📂 Retrieved ${imagesList.length} images.");

      if (mounted) {
        setState(() {
          documents = imagesList.map((image) => {
            "imageUrl": image["imageUrl"] as String,
            "uploadedAt": image["uploadedAt"] as String,
          }).toList();
        });
      }
    } catch (e) {
      print("⚠️ Error fetching documents: $e");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> deleteDocument(String userId, String section, String imageUrl) async {
    final String apiUrl =
        "http://10.0.2.2:3000/api/documents/delete?userId=$userId&section=$section&imageUrl=$imageUrl";

    final response = await http.delete(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "✅ Image deleted successfully");
    } else {
      Fluttertoast.showToast(msg: "⚠️ Error deleting image");
    }
  }


  void showDeleteConfirmation(BuildContext context, String userId, String section, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Document?"),
        content: Text("Are you sure you want to delete this document?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              await deleteDocument(userId, section, imageUrl);
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }


  // Format date for better readability
  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return "${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}";
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded , color: Colors.white,),
        ),
        actions: [
          IconButton(
            onPressed: fetchDocuments, // Refresh document list
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
              size: 25,
            ),
          ),
        ],
        backgroundColor: const Color(0xFF535C91),
        title: Text(
          "Univerisitymarksheet",
          style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.07),
        ),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(color: Colors.white),
      )
          : documents.isEmpty
          ? const Center(
        child: Text(
          "No Documents Found",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return Card(
            color: Color(0xFF3E3E4E),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Container(
                child: Image.network(
                  documents[index]["imageUrl"], // Ensure this is valid
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    print("⚠️ Image load failed: $error");
                    return Icon(Icons.image_not_supported, color: Colors.grey[400], size: 40);
                  },
                ),
              ),
              title: Text(
                "Document ${index + 1}",
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                "Uploaded on: ${formatDate(documents[index]["uploadedAt"])}",
                style: TextStyle(color: Colors.grey[400]),
              ),
              trailing: PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onSelected: (String value) async {
                  final User? user = FirebaseAuth.instance.currentUser;
                  if (user == null) {
                    print("❌ User not logged in");
                    return;
                  }
                  final String userId = user.uid;  // Get the logged-in user ID
                  final String section = widget.section;  // Use the section from the widget
                  final String imageUrl = documents[index]["imageUrl"]; // Get image URL

                  switch (value) {
                    case 'Download PDF':
                      print('📥 Downloading PDF...');
                      downloadPDF(context, userId, section ,imageUrl);
                      break;
                    case 'delete':
                      print('Delete tapped');

                      // Show a confirmation dialog before deleting
                      showDeleteConfirmation(context, userId, section, imageUrl);
                      break;

                    case 'Download Image':
                      downloadImage(context,imageUrl, "univerisitymarksheet_${index + 1}.jpg");
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Download PDF',
                    child: Text('Download PDF'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Download Image',
                    child: Text('Download Image'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'delete',
                    child: Text('Delete' , style: TextStyle(color: Colors.red),),
                  ),
                ],
              ),

            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await pickImage(context, widget.section);
          fetchDocuments(); // Refresh list after upload
        },
        label: const Text("Scan Documents"),
        icon: const Icon(Icons.document_scanner),
      ),
    );
  }
}
