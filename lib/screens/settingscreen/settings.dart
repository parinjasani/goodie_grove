import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Account Settings"),
            leading: Icon(Icons.account_circle),
            onTap: () {
              // Handle navigation to account settings
            },
          ),
          ListTile(
            title: Text("Notifications"),
            leading: Icon(Icons.notifications),
            onTap: () {
              // Handle navigation to notification settings
            },
          ),
          ListTile(
            title: Text("Privacy"),
            leading: Icon(Icons.lock),
            onTap: () {
              // Handle navigation to privacy settings
            },
          ),
          ListTile(
            title: Text("About Us"),
            leading: Icon(Icons.info),
            onTap: () {
              // Handle navigation to About Us page
            },
          ),
          ListTile(
            title: Text("Logout"),
            leading: Icon(Icons.logout),
            onTap: () async {
              // Implement logout logic
            },
          ),
        ],
      ),
    );
  }
}
