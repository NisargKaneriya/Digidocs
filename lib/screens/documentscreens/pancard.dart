import 'package:flutter/material.dart';
class Pancard extends StatefulWidget {
  const Pancard({super.key});

  @override
  State<Pancard> createState() => _PancardState();
}

class _PancardState extends State<Pancard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        title: Text("Pan Card"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "This is the Pan Card page",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
