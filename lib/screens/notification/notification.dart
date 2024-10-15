import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Function to send a notification and show SnackBar
  Future<void> sendNotification(BuildContext context) async {
    String title = _titleController.text;
    String message = _messageController.text;

    if (title.isEmpty || message.isEmpty) {
      _showSnackBar(context, "Title and message cannot be empty!", Colors.red);
      return;
    }

    try {
      // Save the notification in Firestore
      await FirebaseFirestore.instance.collection('notifications').add({
        'title': title,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _showSnackBar(context, "Notification sent successfully!", Colors.green);

      // Clear text fields after successful submission
      _titleController.clear();
      _messageController.clear();
    } catch (e) {
      _showSnackBar(context, "Error: $e", Colors.red);
    }
  }

  // SnackBar function to display feedback messages
  void _showSnackBar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(16.0),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel - Send Notification'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: 600,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Send Notification',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Notification Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    labelText: 'Notification Message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 5,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => sendNotification(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Send Notification',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class NotificationScreen extends StatefulWidget {
//   @override
//   _NotificationScreenState createState() =>
//       _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _messageController = TextEditingController();
//
//   Future<void> sendNotificationToUsers(String title, String message) async {
//     const String serverKey =
//         'YOUR_SERVER_KEY'; // Replace with your Firebase server key
//
//     try {
//       await http.post(
//         Uri.parse('https://fcm.googleapis.com/fcm/send'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'key=$serverKey',
//         },
//         body: jsonEncode({
//           'to': '/topics/allUsers', // All users subscribed to 'allUsers' topic
//           'notification': {
//             'title': title,
//             'body': message,
//             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//           },
//           'data': {
//             'title': title,
//             'message': message,
//           },
//         }),
//       );
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Notification sent successfully')),
//       );
//     } catch (e) {
//       print('Error sending notification: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Admin - Send Notification')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _titleController,
//               decoration: InputDecoration(labelText: 'Notification Title'),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _messageController,
//               decoration: InputDecoration(labelText: 'Notification Message'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 sendNotificationToUsers(
//                     _titleController.text, _messageController.text);
//               },
//               child: Text('Send Notification'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class NotificationScreen extends StatefulWidget {
//   @override
//   _NotificationScreenState createState() =>
//       _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _messageController = TextEditingController();
//
//   Future<void> sendNotificationToUsers(String title, String message) async {
//     const String serverKey =
//         'YOUR_SERVER_KEY'; // Replace with your Firebase server key
//
//     try {
//       await http.post(
//         Uri.parse('https://fcm.googleapis.com/fcm/send'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'key=$serverKey',
//         },
//         body: jsonEncode({
//           'to': '/topics/allUsers', // All users subscribed to 'allUsers' topic
//           'notification': {
//             'title': title,
//             'body': message,
//             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//           },
//           'data': {
//             'title': title,
//             'message': message,
//           },
//         }),
//       );
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Notification sent successfully')),
//       );
//     } catch (e) {
//       print('Error sending notification: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Admin - Send Notification')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _titleController,
//               decoration: InputDecoration(labelText: 'Notification Title'),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _messageController,
//               decoration: InputDecoration(labelText: 'Notification Message'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 sendNotificationToUsers(
//                     _titleController.text, _messageController.text);
//               },
//               child: Text('Send Notification'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
