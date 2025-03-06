// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:digidocs/global.dart';
// import 'package:digidocs/services/firebase_storage_service.dart'; // Import your upload service
//
// class ImagePreviewScreen extends StatefulWidget {
//   final String imagePath;
//   final String documentType; // Add documentType
//
//   const ImagePreviewScreen({Key? key, required this.imagePath, required this.documentType}) : super(key: key); // Modify constructor
//
//   @override
//   _ImagePreviewScreenState createState() => _ImagePreviewScreenState();
// }
//
// class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Captured Image")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.file(File(widget.imagePath)),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 await pickImageFromCamera(context, widget.documentType); //pass document type
//                 setState(() {});
//               },
//               child: const Text("Retake Photo"),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 // Upload image here
//                 String? imageUrl = await FirebaseStorageService().uploadImage(File(widget.imagePath), widget.documentType);
//                 if (imageUrl != null) {
//                   // Store imageUrl in Firestore, navigate, etc.
//                   print("Image uploaded to ${widget.documentType}");
//                   Navigator.pop(context); // Go back after upload
//                 } else {
//                   // Handle upload error
//                   print("upload error");
//                 }
//               },
//               child: const Text("Upload Image"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'dart:io';

class ImagePreviewScreen extends StatefulWidget {
  final String imagePath; // Receive the image path

  const ImagePreviewScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  _ImagePreviewScreenState createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Captured Image")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(File(widget.imagePath)), // Show the captured image
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context), // Go back to the camera screen
              child: Text("Retake Photo"),
            ),
          ],
        ),
      ),
    );
  }
}
