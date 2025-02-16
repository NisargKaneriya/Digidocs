import 'package:flutter/material.dart';

class Transportaional extends StatefulWidget {
  const Transportaional({super.key});

  @override
  State<Transportaional> createState() => _TransportaionalState();
}

class _TransportaionalState extends State<Transportaional> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        title: Text("Transportaional"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "This is the Transportaional page",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
