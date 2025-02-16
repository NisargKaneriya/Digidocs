import 'package:flutter/material.dart';
class Otherdocs extends StatefulWidget {
  const Otherdocs({super.key});

  @override
  State<Otherdocs> createState() => _OtherdocsState();
}

class _OtherdocsState extends State<Otherdocs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        title: Text("Other Document"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "This is the Other Document page",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
