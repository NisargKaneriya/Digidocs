import 'package:digidocs/screens/camerascreens/maincamerascreen.dart';
import 'package:digidocs/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:digidocs/buttoncolor.dart';

class Addharcard extends StatefulWidget {
  const Addharcard({super.key});

  @override
  State<Addharcard> createState() => _AddharcardState();
}

class _AddharcardState extends State<Addharcard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.document_scanner_outlined))],
        backgroundColor: Color(0xFF535C91),
        title: Text("Addhar card"  , style: TextStyle(color: Colors.white ,fontSize: screenWidth * 0.07),),
      ),
      body: Center(
        child: Text(
          "This is the Addhar card page",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold , color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Maincamerascreen()));
        },
        label: Text("Scan Documents"),
        icon: Icon(Icons.document_scanner),
      ),
    );
  }
}
