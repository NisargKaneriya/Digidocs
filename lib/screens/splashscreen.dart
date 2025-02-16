import 'package:digidocs/screens/emailverification.dart';
import 'package:digidocs/screens/homepage.dart';
import 'package:digidocs/screens/onboarding%20screens/onboardingscreen1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF070F2B),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double fontSize = constraints.maxWidth * 0.08; // Responsive font size
          return Center(
            child: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text(
                    "Digidocs",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  Future.delayed(Duration(seconds: 10), () {
                    if (snapshot.hasData && snapshot.data != null) {
                      if (snapshot.data!.emailVerified) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Homepage()),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Emailverification()),
                        );
                      }
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => OnboardingScreen1()),
                      );
                    }
                  });
                  return Text(
                    "Digidocs",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
