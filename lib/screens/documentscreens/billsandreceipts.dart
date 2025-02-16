import 'package:flutter/material.dart';

class Billsandreceipts extends StatefulWidget {
  const Billsandreceipts({super.key});

  @override
  State<Billsandreceipts> createState() => _BillsandreceiptsState();
}

class _BillsandreceiptsState extends State<Billsandreceipts> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        title: Text("Bills And Recipt", style: TextStyle(color: Colors.white ,fontSize: screenWidth * 0.07),),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "This is the bills and receipt page",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
