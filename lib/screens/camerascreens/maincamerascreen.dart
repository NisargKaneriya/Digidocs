// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class Maincamerascreen extends StatefulWidget {
//   const Maincamerascreen({super.key});
//
//   @override
//   State<Maincamerascreen> createState() => _MaincamerascreenState();
// }
//
// class _MaincamerascreenState extends State<Maincamerascreen> {
//   File ? _selectedimage;
//   @override
//
//   Future _pickimagefromgallery() async{
//     await ImagePicker().pickImage(source: ImageSource.gallery);
//   }
//
//   Future _pickimagefromcamera() async{
//     await ImagePicker().pickImage(source: ImageSource.camera);
//   }
//
//
//   Widget build(BuildContext context) {
//     return Container(
//       color: Color(0xFF1E1E2E),
//       child: Padding(
//         padding: const EdgeInsets.only(top: 55 , bottom: 20 , left: 8 , right: 8),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             // Card(
//             //   child: Container(
//             //     height: MediaQuery.of(context).size.height - 300,
//             //
//             //   ),
//             // ),
//             _selectedimage != null ? Image.file(_selectedimage!) : const Text("Please select the image"),
//             Card(
//               color: Color(0xFF535C91),
//               child: Container(
//                 height: 100,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     InkWell(
//                       child: const Icon(
//                         Icons.qr_code_scanner,
//                         size: 40,
//                         color: Colors.white,
//                       ),
//                       onTap: () {},
//                     ),
//                     InkWell(
//                       child: const Icon(
//                         Icons.camera,
//                         size: 60,
//                         color: Colors.white,
//                       ),
//                       onTap: () {
//                         _pickimagefromcamera();
//                       },
//                     ),
//                     InkWell(
//                       child: const Icon(
//                         Icons.image_outlined,
//                         size: 40,
//                         color: Colors.white,
//                       ),
//                       onTap: ()  {
//                         _pickimagefromgallery();
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'dart:ui' as ui;
import 'package:digidocs/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class Maincamerascreen extends StatefulWidget {
  const Maincamerascreen({super.key});

  @override
  State<Maincamerascreen> createState() => _MaincamerascreenState();
}

class _MaincamerascreenState extends State<Maincamerascreen> {
  File? _selectedImage;
  final ImagePicker _imagePicker = ImagePicker();
  List<Offset> _points = [];

  // ✅ Pick & Crop Image
  Future<void> _pickAndCropImage(ImageSource source) async {
    final XFile? image = await _imagePicker.pickImage(source: source);
    if (image != null) {
      CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "Crop Image",
            toolbarColor: Colors.deepPurple,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: false,
          ),
          IOSUiSettings(title: "Crop Image"),
        ],
      );

      if (croppedImage != null) {
        setState(() {
          _selectedImage = File(croppedImage.path);
        });
      }
    }
  }

  // ✅ Draw on Image
  void _startDrawing() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DrawScreen(imageFile: _selectedImage)),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        leading: IconButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));}, icon: Icon(Icons.arrow_back_rounded)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 55, bottom: 20, left: 8, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ✅ Image Display Container
            Container(
              height: screenHeight * 0.5,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: _selectedImage != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  _selectedImage!,
                  fit: BoxFit.contain,
                ),
              )
                  : const Center(
                child: Text(
                  "Please select an image",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),

            // ✅ Button Panel
            Card(
              color: const Color(0xFF535C91),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Container(
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.qr_code_scanner, size: 40, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera, size: 60, color: Colors.white),
                      onPressed: () => _pickAndCropImage(ImageSource.camera),
                    ),
                    IconButton(
                      icon: const Icon(Icons.image_outlined, size: 40, color: Colors.white),
                      onPressed: () => _pickAndCropImage(ImageSource.gallery),
                    ),
                    IconButton(
                      icon: const Icon(Icons.brush, size: 40, color: Colors.white),
                      onPressed: _selectedImage != null ? _startDrawing : null,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Drawing Screen
class DrawScreen extends StatefulWidget {
  final File? imageFile;

  const DrawScreen({super.key, required this.imageFile});

  @override
  State<DrawScreen> createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
  List<Offset?> _points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Draw on Image"),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {}, // Implement save function later
          ),
        ],
      ),
      body: Stack(
        children: [
          if (widget.imageFile != null)
            Center(
              child: Image.file(widget.imageFile!, fit: BoxFit.contain),
            ),
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                RenderBox renderBox = context.findRenderObject() as RenderBox;
                _points.add(renderBox.globalToLocal(details.globalPosition));
              });
            },
            onPanEnd: (details) {
              _points.add(null);
            },
            child: CustomPaint(
              painter: DrawingPainter(_points),
              size: Size.infinite,
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ Drawing Painter
class DrawingPainter extends CustomPainter {
  final List<Offset?> points;
  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}
