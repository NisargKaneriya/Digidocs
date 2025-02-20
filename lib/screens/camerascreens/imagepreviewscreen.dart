import 'package:flutter/material.dart';
import 'dart:io';
import 'package:digidocs/global.dart';

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
                onPressed: () async {
                  await pickImageFromCamera(context);
                  setState(() {});
                }, // Go back to the camera screen
              child: Text("Retake Photo"),
            ),
          ],
        ),
      ),
    );
  }
}
