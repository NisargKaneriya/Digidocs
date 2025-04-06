import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

Future<String> recognizeText(File imageFile) async {
  final textRecognizer = TextRecognizer();
  final inputImage = InputImage.fromFile(imageFile);

  final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
  await textRecognizer.close();

  String extractedText = "";
  for (TextBlock block in recognizedText.blocks) {
    for (TextLine line in block.lines) {
      extractedText += "${line.text}\n";
    }
  }

  return extractedText;
}
