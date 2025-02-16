import 'package:flutter/material.dart';
class Idcard extends StatefulWidget {
  const Idcard({super.key});

  @override
  State<Idcard> createState() => _IdcardState();
}

class _IdcardState extends State<Idcard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        title: Text("Id card"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "This is the Id card page",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
