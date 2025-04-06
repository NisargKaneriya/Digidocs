import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart'; // Optional if you want app-specific dirs

/// Applies a filter to the given image file and returns a new filtered File.
/// If 'clear' is selected, it restores the original unfiltered image.
Future<File> applyFilter(File imageFile, String filterType) async {
  final String originalBackupPath = '${imageFile.parent.path}/original_backup.jpg';
  final File originalBackupFile = File(originalBackupPath);

  // Step 1: Create a backup of the original image once
  if (!await originalBackupFile.exists()) {
    await imageFile.copy(originalBackupPath);
  }

  // Step 2: Handle the 'clear' filter
  if (filterType == 'clear') {
    print('Restoring original image from backup: $originalBackupPath');
    final String restoredPath =
        '${imageFile.parent.path}/restored_${DateTime.now().millisecondsSinceEpoch}.jpg';
    return await originalBackupFile.copy(restoredPath);
  }

  // Step 3: Decode the image
  final bytes = await imageFile.readAsBytes();
  img.Image? originalImage = img.decodeImage(Uint8List.fromList(bytes));

  if (originalImage == null) {
    throw Exception("Failed to decode image. The image might be corrupt or in an unsupported format.");
  }

  img.Image image = img.copyCrop(originalImage,
      x: 0, y: 0, width: originalImage.width, height: originalImage.height);

  // Step 4: Apply the selected filter
  switch (filterType) {
    case 'grayscale':
      image = img.grayscale(image);
      break;
    case 'invert':
      image = img.invert(image);
      break;
    case 'sepia':
      image = img.sepia(image);
      break;
    case 'vibrant':
      image = img.adjustColor(image, saturation: 1.5);
      break;
    case 'soft_tone':
      image = img.adjustColor(image, brightness: 20, saturation: 0.8);
      break;
    case 'ocv':
      image = img.contrast(image, contrast: 180);
      image = img.adjustColor(image, saturation: 1.2);
      break;
    case 'black_and_white':
      image = img.grayscale(image);
      image = img.contrast(image, contrast: 200);
      break;
    default:
      print('Unknown filter: $filterType');
      return imageFile;
  }

  // Step 5: Save the filtered image
  final String filteredPath =
      '${imageFile.parent.path}/filtered_${DateTime.now().millisecondsSinceEpoch}.jpg';
  final File filteredFile = File(filteredPath)..writeAsBytesSync(img.encodeJpg(image));

  print('Filtered image saved at: $filteredPath');
  return filteredFile;
}
