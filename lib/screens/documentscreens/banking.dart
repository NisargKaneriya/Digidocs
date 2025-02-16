
import 'package:flutter/material.dart';

class Banking extends StatefulWidget {
  const Banking({super.key});

  @override
  State<Banking> createState() => _BankingState();
}

class _BankingState extends State<Banking> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        title: Text("Banking Document" , style: TextStyle(color: Colors.white ,fontSize: screenWidth * 0.07),),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "This is the Banking Document page",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
