import 'package:digidocs/screens/homepage.dart';
import 'package:digidocs/screens/login.dart';
import 'package:digidocs/buttoncolor.dart';
import 'package:digidocs/screens/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  signup() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      Get.offAll(SplashScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        return Scaffold(
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
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth < 600 ? 16.0 : screenWidth * 0.15,
                vertical: screenWidth < 600 ? 10.0 : 20.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/singup.png",
                        height: screenWidth < 400 ? 115 : 220,
                        width: screenWidth * 0.8,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: screenWidth < 400 ? 32.0 : 40.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Securely store and manage your documents create your account today!',
                      style: TextStyle(
                        fontSize: screenWidth < 400 ? 16 : 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),
                    buildInputField("Email", email, "Enter Your Email", false),
                    SizedBox(height: 10),
                    buildInputField("Password", password, "Enter Your Password", true, isPassword: true),
                    SizedBox(height: 10),
                    buildInputField("Confirm Password", confirmPassword, "Enter Your Confirm Password", true, isPassword: true, isConfirm: true),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: signup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ButtonColors.secoundary,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(300.0)),
                        ),
                        child: Text('Continue', style: TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account? ', style: TextStyle(fontSize: 16, color: Colors.white)),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                            },
                            child: Text('Login', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ],
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

  Widget buildInputField(String label, TextEditingController controller, String hint, bool obscure,
      {bool isPassword = false, bool isConfirm = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 4.0),
        TextFormField(
          controller: controller,
          obscureText: isPassword ? obscure : false,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: hint,
            labelStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(24)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(24)),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                obscure ? Icons.visibility_off : Icons.visibility,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  if (isConfirm) {
                    _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
                  } else {
                    _obscureTextPassword = !_obscureTextPassword;
                  }
                });
              },
            )
                : null,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your $label';
            }
            if (isConfirm && value != password.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
      ],
    );
  }
}