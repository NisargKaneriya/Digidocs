import 'package:flutter/material.dart';

class Covidvaccine extends StatefulWidget {
  const Covidvaccine({super.key});

  @override
  State<Covidvaccine> createState() => _CovidvaccineState();
}

class _CovidvaccineState extends State<Covidvaccine> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        title: Text("Covid vaccine certificate" , style: TextStyle(color: Colors.white ,fontSize: screenWidth * 0.07),),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "This is the  Covid vaccine certificate page",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
