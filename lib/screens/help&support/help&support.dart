import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help & Support"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Frequently Asked Questions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(height: 16),
            ListTile(
              title: Text("How can I reset my password?"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Handle navigation to a detailed FAQ or guide
              },
            ),
            ListTile(
              title: Text("How to use the gift card?"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Handle navigation to a detailed FAQ or guide
              },
            ),
            // Add more FAQ items as needed
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Navigate to contact support
              },
              child: Text("Contact Support"),
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
