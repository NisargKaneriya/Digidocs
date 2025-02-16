import 'dart:ui';
import 'package:digidocs/screens/Signup.dart';
import 'package:digidocs/screens/documentscreens/addharcard.dart';
import 'package:digidocs/screens/documentscreens/banking.dart';
import 'package:digidocs/screens/documentscreens/billsandreceipts.dart';
import 'package:digidocs/screens/documentscreens/covidvaccine.dart';
import 'package:digidocs/screens/documentscreens/drivinglincense.dart';
import 'package:digidocs/screens/documentscreens/healthandwellness.dart';
import 'package:digidocs/screens/documentscreens/hscmarksheet.dart';
import 'package:digidocs/screens/documentscreens/incomecertificate.dart';
import 'package:digidocs/screens/documentscreens/otherdocs.dart';
import 'package:digidocs/screens/documentscreens/passport.dart';
import 'package:digidocs/screens/documentscreens/rationcard.dart';
import 'package:digidocs/screens/documentscreens/sportsandcultural.dart';
import 'package:digidocs/screens/documentscreens/sscmarksheet.dart';
import 'package:digidocs/screens/documentscreens/transportaional.dart';
import 'package:digidocs/screens/documentscreens/univerisitymarksheet.dart';
import 'package:digidocs/screens/documentscreens/vehicleragistration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void signout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );
  }

  final List<Map<String, dynamic>> scanOptions = [
    {"title": "Aadhar Card", "subtitle": "Scan Aadhar Card", "icon": Icons.credit_card, "screen": Addharcard()},
    {"title": "Banking Docs", "subtitle": "Scan Banking Documents", "icon": Icons.account_balance, "screen": Banking()},
    {"title": "Driving License", "subtitle": "Scan Driving License", "icon": Icons.directions_car, "screen": Drivinglincense()},
    {"title": "Passports", "subtitle": "Scan Passports", "icon": Icons.flight, "screen": Passport()},
    {"title": "Bills & Receipts", "subtitle": "Scan Your Bills", "icon": Icons.receipt_long, "screen": Billsandreceipts()},
    {"title": "HSC Marksheet", "subtitle": "Scan Marksheet", "icon": Icons.school, "screen": Hscmarksheet()},
    {"title": "SSC Marksheet", "subtitle": "Scan Marksheet", "icon": Icons.school, "screen": Sscmarksheet()},
    {"title": "Univeristy Marksheet", "subtitle": "Scan Marksheet", "icon": Icons.school, "screen": Univerisitymarksheet()},
    {"title": "Income Certificates", "subtitle": "Scan Certificates", "icon": Icons.receipt_long, "screen": Incomecertificate()},
    {"title": "Ration Certificates", "subtitle": "Scan Certificates", "icon": Icons.add_card, "screen": Rationcard()},
    {"title": "Vehicle Ragistration", "subtitle": "Scan RC", "icon": Icons.car_rental, "screen": Vehicleragistration()},
    {"title": "Sports and cultural", "subtitle": "Scan Certificates", "icon": Icons.sports_baseball_outlined, "screen": Sportsandcultural()},
    {"title": "Health and Wellness", "subtitle": "Scan Certificates", "icon": Icons.health_and_safety_outlined, "screen": Healthandwellness()},
    {"title": "Transportation", "subtitle": "Scan Certificates", "icon": Icons.emoji_transportation, "screen": Transportaional()},
    {"title": "Covid Certificates", "subtitle": "Scan Certificates", "icon": Icons.receipt_outlined, "screen": Covidvaccine()},
    {"title": "Other Docs", "subtitle": "Scan Document", "icon": Icons.document_scanner_outlined, "screen": Otherdocs()},
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("DigiDocs" , style: TextStyle(color: Colors.white ,fontSize: screenWidth * 0.07),),
            backgroundColor: Color(0xFF535C91),
            elevation: 0,
            pinned: true,
            floating: false,
            leading: IconButton(
              icon: Icon(Icons.menu, size: screenWidth * 0.07, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.logout, size: screenWidth * 0.07, color: Colors.white),
                onPressed: () {
                  signout();
                },
              ),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    "Select a Scan Option",
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  var item = scanOptions[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => item["screen"]),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                        boxShadow: [
                          BoxShadow(color: Colors.blue.withOpacity(0.2), blurRadius: 10, spreadRadius: 1),
                          BoxShadow(color: Colors.purple.withOpacity(0.2), blurRadius: 10, spreadRadius: 1),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blueAccent.withOpacity(0.6),
                                      Colors.purpleAccent.withOpacity(0.6),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                padding: EdgeInsets.all(screenWidth * 0.03),
                                child: Icon(
                                  item["icon"],
                                  size: screenWidth * 0.08,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Text(
                                item["title"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                softWrap: true,
                              ),
                              SizedBox(height: screenHeight * 0.005),
                              Text(
                                item["subtitle"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.03,
                                  color: Colors.white70,
                                ),
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: scanOptions.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth > 600 ? 3 : 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
