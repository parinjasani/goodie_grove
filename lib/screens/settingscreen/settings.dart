import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),

      ),
      body: ListView(
        children: [

          ListTile(
            title: Text("Account Settings"),
            leading: Icon(Icons.account_circle,size: 35),
            onTap: () {
              // Handle navigation to account settings
            },
          ),
          Divider(),
          ListTile(
            title: Text("Notifications"),
            leading: Icon(Icons.notifications,size: 35),
            onTap: () {
              // Handle navigation to notification settings
            },
          ),
          Divider(),
          ListTile(
            title: Text("Privacy"),
            leading: Icon(Icons.lock,size: 35),
            onTap: () {
              // Handle navigation to privacy settings
            },
          ),
          Divider(),
          ListTile(
            title: Text("About Us"),
            leading: Icon(Icons.info,size: 35),
            onTap: () {
              // Handle navigation to About Us page
            },
          ),
          Divider(),
          ListTile(
            title: Text("Logout"),
            leading: Icon(Icons.logout,size: 35),
            onTap: () async {
              // Implement logout logic
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
