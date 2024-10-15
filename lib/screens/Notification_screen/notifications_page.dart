import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppNotificationScreens extends StatefulWidget {
  @override
  _AppNotificationScreensState createState() => _AppNotificationScreensState();
}

class _AppNotificationScreensState extends State<AppNotificationScreens> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _configureFirebaseListeners();
  }

  void _configureFirebaseListeners() {
    // Subscribe to 'allUsers' topic
    _firebaseMessaging.subscribeToTopic('allUsers');

    // Handle foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotificationDialog(
        message.notification?.title,
        message.notification?.body,
      );
    });
  }

  void _showNotificationDialog(String? title, String? body) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title ?? 'New Notification'),
        content: Text(body ?? ''),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var notification = snapshot.data!.docs[index];
              String title = notification['title'] ?? 'No Title';
              String description = notification['message'] ?? 'No Description';
              Timestamp timestamp = notification['timestamp'];
              String date = _formatTimestamp(timestamp);

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(description),
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          date,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Format timestamp to a readable string
  String _formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    return "${dateTime.day}-${dateTime.month}-${dateTime.year} "
        "${dateTime.hour}:${dateTime.minute}";
  }
}


// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AppNotificationScreens extends StatefulWidget {
//   @override
//   _AppNotificationScreensState createState() => _AppNotificationScreensState();
// }
//
// class _AppNotificationScreensState extends State<AppNotificationScreens> {
//   FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   @override
//   void initState() {
//     super.initState();
//     _configureFirebaseListeners();
//   }
//
//   void _configureFirebaseListeners() {
//     // Subscribe to 'allUsers' topic
//     _firebaseMessaging.subscribeToTopic('allUsers');
//
//     // Handle foreground notifications
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       _showNotificationDialog(message.notification?.title,
//           message.notification?.body);
//     });
//   }
//
//   void _showNotificationDialog(String? title, String? body) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title ?? 'New Notification'),
//         content: Text(body ?? ''),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Notifications')),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('notifications')
//             .orderBy('timestamp', descending: true)
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               var notification = snapshot.data!.docs[index];
//               return ListTile(
//                 title: Text(notification['title']),
//                 subtitle: Text(notification['message']),
//                 leading: Icon(Icons.notifications),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AppNotificationScreens extends StatefulWidget {
//   @override
//   _AppNotificationScreensState createState() => _AppNotificationScreensState();
// }
//
// class _AppNotificationScreensState extends State<AppNotificationScreens> {
//   FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   @override
//   void initState() {
//     super.initState();
//     _configureFirebaseListeners();
//   }
//
//   void _configureFirebaseListeners() {
//     // Subscribe to 'allUsers' topic
//     _firebaseMessaging.subscribeToTopic('allUsers');
//
//     // Handle foreground notifications
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       _showNotificationDialog(message.notification?.title,
//           message.notification?.body);
//     });
//   }
//
//   void _showNotificationDialog(String? title, String? body) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title ?? 'New Notification'),
//         content: Text(body ?? ''),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Notifications')),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('notifications')
//             .orderBy('timestamp', descending: true)
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               var notification = snapshot.data!.docs[index];
//               return ListTile(
//                 title: Text(notification['title']),
//                 subtitle: Text(notification['message']),
//                 leading: Icon(Icons.notifications),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // class AppNotificationScreens extends StatefulWidget {
// //   @override
// //   _AppNotificationScreensState createState() => _AppNotificationScreensState();
// // }
// //
// // class _AppNotificationScreensState extends State<AppNotificationScreens> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Your Notifications'),
// //         backgroundColor: Colors.teal,
// //       ),
// //       body: StreamBuilder(
// //         stream: FirebaseFirestore.instance
// //             .collection('notifications')
// //             .orderBy('timestamp', descending: true)
// //             .snapshots(),
// //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //           if (!snapshot.hasData) {
// //             return Center(child: CircularProgressIndicator());
// //           }
// //
// //           if (snapshot.data!.docs.isEmpty) {
// //             return Center(child: Text('No notifications available.'));
// //           }
// //
// //           return ListView.builder(
// //             itemCount: snapshot.data!.docs.length,
// //             itemBuilder: (context, index) {
// //               var notification = snapshot.data!.docs[index];
// //               return ListTile(
// //                 title: Text(notification['title'] ?? 'No Title'),
// //                 subtitle: Text(notification['message'] ?? 'No Message'),
// //                 leading: Icon(Icons.notifications, color: Colors.teal),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// //
//
// // import 'package:flutter/material.dart';
// //
// // class AppNotificationScreens extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Notifications"),
// //         backgroundColor: Colors.black38,
// //       ),
// //       body: ListView(
// //         children: [
// //           NotificationItem(
// //             title: "New Gift Available!",
// //             description: "Check out the latest gifts added to the catalog.",
// //             date: "Oct 10, 2024",
// //           ),
// //           NotificationItem(
// //             title: "Your Gift is on the Way!",
// //             description: "Your selected gift will be delivered shortly.",
// //             date: "Oct 9, 2024",
// //           ),
// //           // Add more notifications as needed
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // class NotificationItem extends StatelessWidget {
// //   final String title;
// //   final String description;
// //   final String date;
// //
// //   const NotificationItem({
// //     required this.title,
// //     required this.description,
// //     required this.date,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
// //       child: Padding(
// //         padding: EdgeInsets.all(16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
// //             SizedBox(height: 4),
// //             Text(description),
// //             SizedBox(height: 8),
// //             Align(alignment: Alignment.bottomRight, child: Text(date, style: TextStyle(color: Colors.grey))),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
