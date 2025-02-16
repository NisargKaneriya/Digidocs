import 'package:digidocs/buttoncolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Resetpassword extends StatefulWidget {
  const Resetpassword({super.key});

  @override
  State<Resetpassword> createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  TextEditingController email = TextEditingController();

  reset() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C75B0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, size: 30, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth > 600 ? 400 : double.infinity,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/resetpassword.png",
                        height: constraints.maxWidth > 600 ? 250 : 200,
                        width: constraints.maxWidth > 600 ? 350 : 250,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Reset Password',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: constraints.maxWidth > 600 ? 35.0 : 30.0,
                        color: ButtonColors.textcolor,
                      ),
                    ),
                    Text(
                      'Forgot your password? Restore access to your important documents effortlessly.',
                      style: TextStyle(
                        fontSize: constraints.maxWidth > 600 ? 20 : 18,
                        fontWeight: FontWeight.w400,
                        color: ButtonColors.textcolor,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text('Email',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: ButtonColors.textcolor)),
                    const SizedBox(height: 4.0),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: email,
                      decoration: InputDecoration(
                        labelText: 'Enter Your Email',
                        labelStyle: TextStyle(color: ButtonColors.textcolor),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: reset,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ButtonColors.secoundary,
                          minimumSize: Size(
                              constraints.maxWidth > 600 ? 300 : double.infinity, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
