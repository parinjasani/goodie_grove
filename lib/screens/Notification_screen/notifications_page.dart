import 'package:flutter/material.dart';

class AppNotificationScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: [
          NotificationItem(
            title: "New Gift Available!",
            description: "Check out the latest gifts added to the catalog.",
            date: "Oct 10, 2024",
          ),
          NotificationItem(
            title: "Your Gift is on the Way!",
            description: "Your selected gift will be delivered shortly.",
            date: "Oct 9, 2024",
          ),
          // Add more notifications as needed
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String description;
  final String date;

  const NotificationItem({
    required this.title,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 4),
            Text(description),
            SizedBox(height: 8),
            Align(alignment: Alignment.bottomRight, child: Text(date, style: TextStyle(color: Colors.grey))),
          ],
        ),
      ),
    );
  }
}
