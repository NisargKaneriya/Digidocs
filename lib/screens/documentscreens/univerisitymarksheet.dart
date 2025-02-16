import 'package:flutter/material.dart';

class Univerisitymarksheet extends StatefulWidget {
  const Univerisitymarksheet({super.key});

  @override
  State<Univerisitymarksheet> createState() => _UniverisitymarksheetState();
}

class _UniverisitymarksheetState extends State<Univerisitymarksheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        title: Text("Univerisity Marksheet"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "This is the Univerisity Marksheet page",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
