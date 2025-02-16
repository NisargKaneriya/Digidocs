import 'package:flutter/material.dart';
class Healthandwellness extends StatefulWidget {
  const Healthandwellness({super.key});

  @override
  State<Healthandwellness> createState() => _HealthandwellnessState();
}

class _HealthandwellnessState extends State<Healthandwellness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        title: Text("Health & Wellness"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "This is the Health and wellness page",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
