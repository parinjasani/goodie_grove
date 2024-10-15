import 'package:finalyeraproject/screens/Notification_screen/notifications_page.dart';
import 'package:finalyeraproject/screens/Profilescreen/profilescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../components/rounded_icon.dart';
import '../../../components/serchfield.dart';



class LayoutHeader extends StatefulWidget {
  @override
  State<LayoutHeader> createState() => _LayoutHeaderState();
}

class _LayoutHeaderState extends State<LayoutHeader> {
  User? currentUser;
  String initialLetter = "U"; // Default initial letter as 'U' for 'User'

  @override
  void initState() {
    super.initState();
    fetchUserInitial();
  }

  // Fetches the initial letter of the signed-in user
  void fetchUserInitial() {
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String? displayName = currentUser!.displayName;
      String? email = currentUser!.email;

      // Set initial letter from displayName or email if displayName is not available
      setState(() {
        initialLetter = (displayName != null && displayName.isNotEmpty)
            ? displayName[0].toUpperCase() // First letter of the displayName
            : email != null && email.isNotEmpty
            ? email[0].toUpperCase() // First letter of the email
            : "U"; // Default if no email or name is found
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // RoundedIcon(
        //   icondata: Icons.menu,
        //   onpress: () {
        //     print("clicked");
        //     Scaffold.of(context).openDrawer();
        //   },
        // ),
        // SizedBox(
        //   width: 10,
        // ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            onTap: () {
              // Navigate to ProfileScreen when avatar is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
            child: CircleAvatar(
              radius: 21,
              backgroundColor: Colors.black38.withOpacity(0.4),
              child: Text(
                initialLetter, // Display initial letter
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        Expanded(child: SearchField()),
        SizedBox(
          width: 10,
        ),
        IconButton(
          icon: Icon(
            Icons.notifications_active, // Notification bell icon
            color: Colors.white,  // You can adjust the color based on your app's theme
            size: 28,  // Adjust the icon size
          ),
          onPressed: () {
            // Handle notification icon press
            Navigator.push(context, MaterialPageRoute(builder: (context) => AppNotificationScreens(),));
          },
        ),
      ],
    );
  }
}
