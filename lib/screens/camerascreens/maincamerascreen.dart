import 'package:camera/camera.dart';
import 'package:digidocs/screens/documentscreens/addharcard.dart';
import 'package:flutter/material.dart';

class Maincamerascreen extends StatefulWidget {
  const Maincamerascreen({super.key});

  @override
  State<Maincamerascreen> createState() => _MaincamerascreenState();
}

class _MaincamerascreenState extends State<Maincamerascreen> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras![1], ResolutionPreset.high);
    await _cameraController!.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF535C91),
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Addharcard()),
          ),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.99,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: _cameraController != null && _cameraController!.value.isInitialized
                ? ClipRRect(
              child: Transform.rotate(
                angle: 90 * 3.1415926535 / 180, // Rotate preview by 90 degrees
                child: CameraPreview(_cameraController!),
              ),
            )
                : const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),),
          Container(child:
          Card(
            color: const Color(0xFF535C91),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.qr_code_scanner, size: 35, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera, size: 50, color: Colors.white),
                    onPressed: () async {
                      final image = await _cameraController!.takePicture();
                      print("Image saved at: ${image.path}");
                    },
                  ),
                ],
              ),
            ),
          )
            ,)



        ],
      ),
    );
  }
}
