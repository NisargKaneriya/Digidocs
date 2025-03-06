import 'package:digidocs/screens/camerascreens/imagepreviewscreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
 // Import the new screen

Future<void> pickImageFromCamera(BuildContext context) async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

  if (pickedFile != null) {
    // Navigate to Image Preview Screen and pass the image path
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImagePreviewScreen(imagePath: pickedFile.path),
      ),
    );
  }
}
