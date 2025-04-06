import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<void> downloadPDF(BuildContext context, String userId, String section, String imageUrl) async {
  try {
    Dio dio = Dio();

    // Encode the image URL to prevent errors in query parameters
    String encodedUrl = Uri.encodeComponent(imageUrl);
    String apiUrl = "http://10.0.2.2:3000/api/documents/download?userId=$userId&section=$section&imageUrl=$encodedUrl";

    // Get public Downloads folder (Android)
    Directory dir = Directory('/storage/emulated/0/Download');

    if (!dir.existsSync()) {
      showSnackBar(context, "❌ Download folder not found");
      return;
    }

    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String savePath = "${dir.path}/${section}_$timestamp.pdf";
    // Download file
    await dio.download(apiUrl, savePath);

    // Success message
    showSnackBar(context, "✅ PDF saved in Downloads folder");
    print("✅ PDF saved to: $savePath");
  } catch (e) {
    showSnackBar(context, "⚠️ Error downloading PDF");
    print("⚠️ Error downloading PDF: $e");
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
