import 'package:flutter/material.dart';

class Hscmarksheet extends StatefulWidget {
  const Hscmarksheet({super.key});

  @override
  State<Hscmarksheet> createState() => _HscmarksheetState();
}

class _HscmarksheetState extends State<Hscmarksheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        title: Text("Hsc Marksheet"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "This is the Hsc Marksheet page",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
