import 'package:flutter/material.dart';
class Sportsandcultural extends StatefulWidget {
  const Sportsandcultural({super.key});

  @override
  State<Sportsandcultural> createState() => _SportsandculturalState();
}

class _SportsandculturalState extends State<Sportsandcultural> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        title: Text("Sports & Cultural"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "This is Sports & Cultural page",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
