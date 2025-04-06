import 'package:digidocs/screens/Signup.dart';
import 'package:digidocs/screens/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:digidocs/buttoncolor.dart';
import 'package:get/get.dart';

class Emailverification extends StatefulWidget {
  const Emailverification({super.key});

  @override
  State<Emailverification> createState() => _EmailverificationState();
}

class _EmailverificationState extends State<Emailverification> {
  @override
  void initState() { // Fixed method name
    super.initState();
    sendverificationlink();
  }

  sendverificationlink() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {  // Ensure user exists and is not already verified
        await user.sendEmailVerification();
        Get.snackbar("Link Sent", "A link has been sent to your email",
            margin: EdgeInsets.all(30), snackPosition: SnackPosition.TOP);
      } else {
        Get.snackbar("Error", "User not logged in or already verified",
            margin: EdgeInsets.all(30), snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to send email verification: $e",
          margin: EdgeInsets.all(30), snackPosition: SnackPosition.TOP);
    }
  }

  reload() async {
    try {
      await FirebaseAuth.instance.currentUser!.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified) {
        Get.offAll(SplashScreen());
      } else {
        Get.snackbar("Not Verified", "Please verify your email first",
            margin: EdgeInsets.all(30), snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to reload user: $e",
          margin: EdgeInsets.all(30), snackPosition: SnackPosition.TOP);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        backgroundColor: Color(0xFF6C75B0),
        title: Text('Verification', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: ButtonColors.tertiary,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_rounded, size: 30, color: Colors.black),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Open your email and click on the link provided to verify your email. Then reload this page using the button below.",
                style: TextStyle(fontSize: 20, color: ButtonColors.textcolor),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: reload,
                style: ElevatedButton.styleFrom(backgroundColor: ButtonColors.tertiary),
                child: Text("Reload", style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ButtonColors.tertiary,
        onPressed: reload,
        child: Icon(Icons.refresh, color: Colors.black),
      ),
    );
  }
}