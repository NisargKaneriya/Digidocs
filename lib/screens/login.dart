import 'package:digidocs/buttoncolor.dart';
import 'package:digidocs/screens/homepage.dart';
import 'package:digidocs/screens/resetpassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isloading = false;

  signin() async {
    setState(() {
      isloading = true;
    });
    try {
      // Sign in the user with Firebase
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text,
          password: password.text
      );

      // Get the Firebase ID token
      String? token = await userCredential.user?.getIdToken();

      if (token == null) {
        throw Exception("Failed to retrieve ID token.");
      }

      // Send the token to the Node.js backend
      final response = await http.post(
        Uri.parse("http://10.0.2.2:3000/api/auth/register"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        Get.offAll(Homepage());
      } else {
        throw Exception(responseData["message"] ?? "Login failed.");
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error Message", e.message ?? "Authentication failed.");
    } catch (e) {
      Get.snackbar("Error Message", e.toString());
    }

    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = MediaQuery.of(context).size.width;
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: const Color(0xFF1E1E2E),
          appBar: AppBar(
            backgroundColor: Color(0xFF6C75B0),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, size: 30, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset("assets/images/login.png", height: 200, width: screenWidth * 0.8),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 40.0, color: ButtonColors.textcolor),
                    ),
                    Text(
                      'Access your digital locker and retrieve your documents anytime, anywhere.',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: ButtonColors.textcolor),
                    ),
                    SizedBox(height: 30),
                    Text('Email', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: ButtonColors.textcolor)),
                    SizedBox(height: 4.0),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: email,
                      decoration: InputDecoration(
                        labelText: 'Enter Your Email',
                        labelStyle: TextStyle(color: ButtonColors.textcolor),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Password', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: ButtonColors.textcolor)),
                    SizedBox(height: 4.0),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: password,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Enter Your Password',
                        labelStyle: TextStyle(color: ButtonColors.textcolor),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: ButtonColors.textcolor),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Resetpassword()));
                        },
                        child: Text('Forgot Password?', style: TextStyle(fontSize: 16, color: Colors.blue)),
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: signin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ButtonColors.secoundary,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(300.0)),
                        ),
                        child: Text('Continue', style: TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

