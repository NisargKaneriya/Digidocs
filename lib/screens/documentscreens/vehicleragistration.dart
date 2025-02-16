import 'package:flutter/material.dart';

class Vehicleragistration extends StatefulWidget {
  const Vehicleragistration({super.key});

  @override
  State<Vehicleragistration> createState() => _VehicleragistrationState();
}

class _VehicleragistrationState extends State<Vehicleragistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        title: Text("Vehicle Ragistration"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "This is the Vehicle Ragistration page",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
