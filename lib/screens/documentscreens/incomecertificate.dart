import 'package:flutter/material.dart';
class Incomecertificate extends StatefulWidget {
  const Incomecertificate({super.key});

  @override
  State<Incomecertificate> createState() => _IncomecertificateState();
}

class _IncomecertificateState extends State<Incomecertificate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        title: Text("Income certificate"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "This is the Income certificate page",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
