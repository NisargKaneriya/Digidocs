import 'package:flutter/material.dart';

class Drivinglincense extends StatefulWidget {
  const Drivinglincense({super.key});

  @override
  State<Drivinglincense> createState() => _DrivinglincenseState();
}

class _DrivinglincenseState extends State<Drivinglincense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        title: Text("Driving Lincense"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "This is the Driving linces page",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
