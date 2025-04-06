import 'package:digidocs/screens/Signup.dart';
import 'package:digidocs/screens/emailverification.dart';
import 'package:digidocs/screens/homepage.dart';
import 'package:digidocs/screens/profilepage.dart';
import 'package:digidocs/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart'; // Ensure this file exists for Firebase options
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request permissions before the app starts
  await _requestPermissions();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //Initilised Supabase
  await Supabase.initialize(
    url: "https://biqddpfztyflbufzvhnn.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJpcWRkcGZ6dHlmbGJ1Znp2aG5uIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE5MjI4NzQsImV4cCI6MjA1NzQ5ODg3NH0.jo3epcfkszRGjcpbti8DJymMBIjbWsdxM30FGmxUG4M",
  );

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.deviceCheck,
  );
  runApp(const MyApp());
}

// Function to request necessary permissions
Future<void> _requestPermissions() async {
  await Permission.camera.request();
  await Permission.storage.request();
  await Permission.photos.request();// Required for Android 13+
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(), // Ensure SplashScreen exists
    );
  }
}
