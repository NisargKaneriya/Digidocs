import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static const String baseUrl = "http://localhost:5000/api/auth/register";

  // Sign In with Email and Password
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }

  // Sign Up with Email and Password
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Sign Up Error: $e");
      return null;
    }
  }

  // Get Firebase Token
  Future<String?> getFirebaseToken() async {
    User? user = _auth.currentUser;
    return user != null ? await user.getIdToken() : null;
  }

  // Send Token to Node.js Backend
  Future<void> registerUserWithBackend() async {
    String? token = await getFirebaseToken();
    if (token == null) {
      print("User not authenticated.");
      return;
    }

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({}),
    );

    if (response.statusCode == 200) {
      print("User registered successfully: ${response.body}");
    } else {
      print("Registration failed: ${response.body}");
    }
  }
}
