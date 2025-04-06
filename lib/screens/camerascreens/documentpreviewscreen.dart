import 'dart:io';
import 'package:digidocs/screens/documentscreens/addharcard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:digidocs/utils/image_utils.dart';
import 'package:digidocs/utils/ml_utils.dart';
import 'package:digidocs/utils/filter_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

class DocumentPreviewScreen extends StatefulWidget {
  final String imagePath;
  final String sectionName; // Dynamically pass section name

  const DocumentPreviewScreen({
    Key? key,
    required this.imagePath,
    required this.sectionName,
  }) : super(key: key);

  @override
  _DocumentPreviewScreenState createState() => _DocumentPreviewScreenState();
}

class _DocumentPreviewScreenState extends State<DocumentPreviewScreen> {
  File? _imageFile;
  String _extractedText = "";

  @override
  void initState() {
    super.initState();
    _imageFile = File(widget.imagePath);
  }

  Future<void> uploadDocument(File imageFile, String userId, String section) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:3000/api/documents/upload'), // Adjust API URL
      );

      // Attach fields
      request.fields['userId'] = userId;
      request.fields['section'] = section;

      // Attach the image file
      request.files.add(
        await http.MultipartFile.fromPath(
          'images', // This should match the backend `req.files` key
          imageFile.path,
          // filename: basename(imageFile.path), // Extract filename
        ),
      );

      var response = await request.send();

      // Read response
      final responseString = await response.stream.bytesToString();
      final responseData = jsonDecode(responseString);

      if (response.statusCode == 200) {
        print("✅ Upload Successful: ${responseData['images']}");
      } else {
        print("❌ Upload Failed: ${responseData['message']}");
      }
    } catch (error) {
      print("⚠️ Upload Error: $error");
    }
  }


  /// 🔹 Performs text recognition using Google ML Kit
  Future<void> _performTextRecognition() async {
    if (_imageFile == null) return;
    String text = await recognizeText(_imageFile!);
    setState(() => _extractedText = text);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Recognized Text"),
        content: SingleChildScrollView(
          child: Text(_extractedText.isNotEmpty ? _extractedText : "No text found"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  /// 🔹 Displays filter selection dialog
  void _showFilterSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.brush),
              title: const Text('Grayscale'),
              onTap: () => _applySelectedFilter('grayscale'),
            ),
            ListTile(
              leading: const Icon(Icons.brush),
              title: const Text('Invert Colors'),
              onTap: () => _applySelectedFilter('invert'),
            ),
            ListTile(
              leading: const Icon(Icons.brush),
              title: const Text('Sepia'),
              onTap: () => _applySelectedFilter('sepia'),
            ),
            ListTile(
              leading: const Icon(Icons.brush),
              title: const Text('vibrant'),
              onTap: () => _applySelectedFilter('vibrant'),
            ),
            ListTile(
              leading: const Icon(Icons.brush),
              title: const Text('soft_tone'),
              onTap: () => _applySelectedFilter('soft_tone'),
            ),
            ListTile(
              leading: const Icon(Icons.brush),
              title: const Text('ocv'),
              onTap: () => _applySelectedFilter('ocv'),
            ),
            ListTile(
              leading: const Icon(Icons.brush),
              title: const Text('black_and_white'),
              onTap: () => _applySelectedFilter('black_and_white'),
            ),
            ListTile(
              leading: const Icon(Icons.brush),
              title: const Text('clear'),
              onTap: () => _applySelectedFilter('clear'),
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Cancel'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  /// 🔹 Applies the selected filter
  void _applySelectedFilter(String filterType) async {
    Navigator.pop(context); // Close filter selection

    if (_imageFile != null) {
      File filteredImage = await applyFilter(_imageFile!, filterType);
      setState(() {
        _imageFile = filteredImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
        ),
        title: Text(widget.sectionName, style: const TextStyle(color: Colors.white)), // Dynamic title
        backgroundColor: const Color(0xFF535C91),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.65,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white38, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _imageFile != null
                    ? Image.file(_imageFile!, fit: BoxFit.contain)
                    : const Center(child: CircularProgressIndicator()),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                color: const Color(0xFF535C91),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.crop, color: Colors.white),
                    onPressed: () async {
                      File? croppedImage = await cropImage(_imageFile!, context);
                      if (croppedImage != null) {
                        setState(() => _imageFile = croppedImage);
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter, color: Colors.white),
                    onPressed: _showFilterSelection,
                  ),
                  IconButton(
                    icon: const Icon(Icons.text_fields, color: Colors.white),
                    onPressed: _performTextRecognition,
                  ),
                  IconButton(
                    icon: const Icon(Icons.save, color: Colors.white),
                    onPressed: () async {
                      try {
                        String? userId = FirebaseAuth.instance.currentUser?.uid; // Get User ID
                        if (userId == null) {
                          print("❌ Error: User not logged in");
                          return;
                        }

                        await uploadDocument(_imageFile!, userId, widget.sectionName);
                        print("✅ Upload initiated successfully!");

                        Navigator.pop(context, true);
                      } catch (e) {
                        print("⚠️ Error fetching user ID: $e");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
