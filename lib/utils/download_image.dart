import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

Future<void> downloadImage(BuildContext context, String url, String filename) async {
  try {
    Dio dio = Dio();

    // Request permission for Android 11+
    // if (await Permission.manageExternalStorage.request().isDenied) {
    //   showSnackBar(context, "Storage permission denied");
    // }
    // Get public Downloads folder
    Directory dir = Directory('/storage/emulated/0/Download');

    if (!dir.existsSync()) {
      showSnackBar(context, "Download folder not found");
      return;
    }

    // Generate unique filename with timestamp
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final uniqueFilename = "$timestamp.jpg";

    final String savePath = "${dir.path}/$uniqueFilename";


    // Download file
    await dio.download(url, savePath);

    // Success message
    showSnackBar(context, "✅ Image saved to Downloads folder");
    print("✅ Image saved to: $savePath");
  } catch (e) {
    showSnackBar(context, "⚠️ Error downloading image");
    print("⚠️ Error downloading image: $e");
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
