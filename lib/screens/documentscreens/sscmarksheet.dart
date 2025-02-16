import 'package:flutter/material.dart';

class Sscmarksheet extends StatefulWidget {
  const Sscmarksheet({super.key});

  @override
  State<Sscmarksheet> createState() => _SscmarksheetState();
}

class _SscmarksheetState extends State<Sscmarksheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        title: Text("Ssc Marksheet"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "This is the Ssc marksheet page",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
