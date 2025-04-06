import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

Future<File?> cropImage(File imageFile, BuildContext context) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Color(0xFF535C91),
        toolbarWidgetColor: Colors.white,
        lockAspectRatio: false, // Allows freeform cropping
        initAspectRatio: CropAspectRatioPreset.original,
      ),
      IOSUiSettings(
        title: 'Crop Image',
        resetAspectRatioEnabled: true,
      ),
      WebUiSettings(
        context: context,
      ),
    ],
  );

  return croppedFile != null ? File(croppedFile.path) : null;
}
