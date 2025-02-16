import 'package:flutter/material.dart';
class Rationcard extends StatefulWidget {
  const Rationcard({super.key});

  @override
  State<Rationcard> createState() => _RationcardState();
}

class _RationcardState extends State<Rationcard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        title: Text("Ration Card"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "This is the Ration Card page",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
