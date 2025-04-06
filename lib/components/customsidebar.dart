import 'package:digidocs/screens/Signup.dart';
import 'package:digidocs/screens/homepage.dart';
import 'package:digidocs/screens/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomSidebar extends StatefulWidget {
  @override
  _CustomSidebarState createState() => _CustomSidebarState();
}

class _CustomSidebarState extends State<CustomSidebar> {
  bool isDarkMode = false;

  String username = "User";
  String email = "";
  String initials = "";

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  String getInitials(String name) {
    List<String> nameParts = name.split(" ");
    if (nameParts.length > 1) {
      return (nameParts[0][0] + nameParts[1][0]).toUpperCase(); // "John Doe" → "JD"
    } else {
      return nameParts[0][0].toUpperCase(); // "Alice" → "A"
    }
  }

  void fetchUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          username = userDoc['username'] ?? "User";
          email = userDoc['email'] ?? "";
          initials = getInitials(username);
        });
      }
    }
  }


  void signout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF1E1E2E), // Dark background color
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF535C91),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Text(
                      initials,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6C75B0),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          username,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          overflow: TextOverflow.ellipsis, // Prevents text from overflowing
                        ),
                        SizedBox(height: 2),
                        Container(
                          width: double.infinity, // Ensures full width usage
                          child: Text(
                            email,
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                            overflow: TextOverflow.ellipsis, // Shortens text with "..."
                            maxLines: 1, // Ensures it doesn't exceed one line
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Color(0xFF535C91), // Background color updated
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),

            SizedBox(height: 10),

            // Sidebar Menu Items with Navigation
            _buildMenuItem(Icons.dashboard, "Home", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Homepage()),
              );
            }),
            _buildMenuItem(Icons.folder, "Profile", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );;
            },),
            Spacer(),

            // Logout Button
            _buildMenuItem(Icons.logout, "Logout", () {
              signout();
            }),

            // Dark Mode Toggle
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ListTile(
                title: Text("Light mode", style: TextStyle(color: Colors.white)),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                  activeColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {bool isActive = false}) {
    return ListTile(
      leading: Icon(icon, color: isActive ? Colors.white : Colors.grey),
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.grey,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: onTap, // Calls the function when tapped
    );
  }
}
