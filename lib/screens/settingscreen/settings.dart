import 'package:finalyeraproject/screens/AboutusScreen/AboutUsScreen.dart';
import 'package:finalyeraproject/screens/privacypolicyScreen/PrivacyPolicyScreen.dart';
import 'package:flutter/material.dart';

import '../Notification_screen/notifications_page.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),

      ),
      body: SafeArea(
        child: ListView(
          children: [

            ListTile(
              title: Text("Account Settings",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700)),
              leading: Icon(Icons.account_circle,size: 35,color: Colors.black),
              onTap: () {
                // Handle navigation to account settings

              },
            ),
            Divider(color: Colors.white,thickness: 2),
            ListTile(
              title: Text("Notifications",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700)),
              leading: Icon(Icons.notifications,size: 35,color: Colors.black),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AppNotificationScreens(),));
                // Handle navigation to notification settings
              },
            ),
            Divider(color: Colors.white,thickness: 2),
            ListTile(
              title: Text("Privacy",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700)),
              leading: Icon(Icons.lock,size: 35,color: Colors.black),
              onTap: () {
                // Handle navigation to privacy settings
                Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyScreen(),));
              },
            ),
            Divider(color: Colors.white,thickness: 2),
            ListTile(
              title: Text("About Us",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700)),
              leading: Icon(Icons.info,size: 35,color: Colors.black),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsScreen(),));
                // Handle navigation to About Us page
              },
            ),
            Divider(color: Colors.white,thickness: 2),
            ListTile(
              title: Text("Logout",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700)),
              leading: Icon(Icons.logout,size: 35,color: Colors.black),
              onTap: () async {
                // Implement logout logic
              },
            ),
            Divider(color: Colors.white,thickness: 2),
          ],
        ),
      ),
    );
  }
}
