import 'package:digidocs/screens/camerascreens/documentpreviewscreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<void> pickImage(BuildContext context, String sectionName) async {
  final ImagePicker picker = ImagePicker();

  // Show a dialog to choose between Camera or Gallery
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext bc) {
      return Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.camera),
            title: Text('Take a Photo'),
            onTap: () async {
              Navigator.pop(context); // Close the modal
              final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
              if (pickedFile != null) {
                navigateToPreviewScreen(context, pickedFile.path, sectionName);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Choose from Gallery'),
            onTap: () async {
              Navigator.pop(context); // Close the modal
              final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                navigateToPreviewScreen(context, pickedFile.path, sectionName);
              }
            },
          ),
        ],
      );
    },
  );
}

// Function to navigate to the Document Preview Screen
void navigateToPreviewScreen(BuildContext context, String imagePath, String sectionName) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DocumentPreviewScreen(
        imagePath: imagePath,
        sectionName: sectionName,
      ),
    ),
  );
}
