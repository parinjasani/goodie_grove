import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class HelpSupportScreen extends StatefulWidget {
  @override
  _HelpSupportScreenState createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
  final TextEditingController messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    listenToMessages();
    saveUserInfo();
  }

  void saveUserInfo() {
    if (currentUser != null) {
      final userEmail = currentUser!.email ?? "No Email";
      final userName = userEmail.split('@')[0];

      messagesRef.child(currentUser!.uid).child("info").set({
        "username": userName,
        "email": userEmail,
      });
    }
  }

  void listenToMessages() {
    messagesRef
        .child(currentUser!.uid)
        .child("messages")
        .orderByChild("timestamp")
        .onValue
        .listen((event) {
      if (event.snapshot.value != null) {
        final data = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
        final loadedMessages = data.values
            .map((msg) => Map<String, dynamic>.from(msg))
            .toList()
          ..sort((a, b) => a['timestamp'].compareTo(b['timestamp']));

        setState(() {
          messages = loadedMessages;
        });
      }
    });
  }

  void sendMessage() {
    if (messageController.text.isEmpty) return;

    final message = {
      "message": messageController.text,
      "sender": "user",
      "timestamp": DateTime.now().millisecondsSinceEpoch,
    };

    messagesRef.child(currentUser!.uid).child("messages").push().set(message);
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Help & Support")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isUser = msg['sender'] == 'user';

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[100] : Colors.green[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(msg['message']),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class HelpSupportScreen extends StatefulWidget {
//   @override
//   _HelpSupportScreenState createState() => _HelpSupportScreenState();
// }
//
// class _HelpSupportScreenState extends State<HelpSupportScreen> {
//   final User? currentUser = FirebaseAuth.instance.currentUser;
//   final DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
//   final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
//   final TextEditingController messageController = TextEditingController();
//
//   List<Map<String, dynamic>> messages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     saveUserInfo();  // Save user information
//     listenToMessages();
//   }
//
//   void saveUserInfo() {
//     if (currentUser != null) {
//       final userEmail = currentUser!.email ?? "No Email";
//       final userName = userEmail.split('@')[0];
//
//       usersRef.child(currentUser!.uid).set({
//         "username": userName,
//         "email": userEmail,
//       });
//     }
//   }
//
//   void listenToMessages() {
//     messagesRef.child(currentUser!.uid).child("messages").orderByChild("timestamp").onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
//       final loadedMessages = data.values
//           .map((msg) => Map<String, dynamic>.from(msg))
//           .toList()
//         ..sort((a, b) => a['timestamp'].compareTo(b['timestamp'])); // Sort messages by timestamp
//
//       setState(() {
//         messages = loadedMessages; // Update state with loaded messages
//       });
//     });
//   }
//
//   void sendMessage() {
//     if (messageController.text.isEmpty) return;
//     final message = {
//       "message": messageController.text,
//       "sender": "user",
//       "timestamp": DateTime.now().millisecondsSinceEpoch,
//     };
//
//     messagesRef.child(currentUser!.uid).child("messages").push().set(message).then((_) {
//       messageController.clear();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Help & Support")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final msg = messages[index];
//                 final isUser = msg['sender'] == 'user';
//                 return Align(
//                   alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     decoration: BoxDecoration(
//                       color: isUser ? Colors.blue[100] : Colors.green[100],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(msg['message']),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: messageController,
//                     decoration: InputDecoration(
//                       hintText: "Type your message...",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class HelpSupportScreen extends StatefulWidget {
//   @override
//   _HelpSupportScreenState createState() => _HelpSupportScreenState();
// }
//
// class _HelpSupportScreenState extends State<HelpSupportScreen> {
//   final User? currentUser = FirebaseAuth.instance.currentUser;
//   final DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
//   final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
//   final TextEditingController messageController = TextEditingController();
//
//   List<Map<String, dynamic>> messages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     saveUserInfo(); // Save user information in Firebase.
//     listenToMessages(); // Load chat messages.
//   }
//
//   // Save user's name and email in Firebase under the "users" node.
//   void saveUserInfo() {
//     if (currentUser != null) {
//       final userEmail = currentUser!.email ?? "No Email";
//       final userName = userEmail.split('@')[0];
//
//       usersRef.child(currentUser!.uid).set({
//         "username": userName,
//         "email": userEmail,
//       });
//     }
//   }
//
//   // Listen for incoming messages from Firebase and maintain order.
//   void listenToMessages() {
//     messagesRef
//         .child(currentUser!.uid)
//         .child("messages")
//         .orderByChild("timestamp")
//         .onValue
//         .listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
//       final loadedMessages = data.values
//           .map((msg) => Map<String, dynamic>.from(msg))
//           .toList()
//         ..sort((a, b) => a['timestamp'].compareTo(b['timestamp'])); // Sort by timestamp
//
//       setState(() {
//         messages = loadedMessages;
//       });
//     });
//   }
//
//   // Send a message to the admin.
//   void sendMessage() {
//     if (messageController.text.isEmpty) return;
//     final message = {
//       "message": messageController.text,
//       "sender": "user",  // Identifies the sender as a user
//       "timestamp": DateTime.now().millisecondsSinceEpoch, // Timestamp for ordering
//     };
//
//     messagesRef.child(currentUser!.uid).child("messages").push().set(message);
//     messageController.clear();
//   }
//
//   // void sendMessage() {
//   //   if (messageController.text.isEmpty) return;
//   //   final message = {
//   //     "message": messageController.text,
//   //     "sender": "user",
//   //     "timestamp": DateTime.now().millisecondsSinceEpoch, // Use timestamp for ordering.
//   //   };
//   //
//   //   messagesRef.child(currentUser!.uid).child("messages").push().set(message);
//   //   messageController.clear();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Help & Support")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final msg = messages[index];
//                 final isUser = msg['sender'] == 'user';
//                 return Align(
//                   alignment: isUser ? Alignment.centerLeft : Alignment.centerRight,
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     decoration: BoxDecoration(
//                       color: isUser ? Colors.blue[100] : Colors.green[100],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(msg['message']),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: messageController,
//                     decoration: InputDecoration(
//                       hintText: "Type your message...",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class HelpSupportScreen extends StatefulWidget {
//   @override
//   _HelpSupportScreenState createState() => _HelpSupportScreenState();
// }
//
// class _HelpSupportScreenState extends State<HelpSupportScreen> {
//   final User? currentUser = FirebaseAuth.instance.currentUser;
//   final DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
//   final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
//   final TextEditingController messageController = TextEditingController();
//
//   List<Map<String, dynamic>> messages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     saveUserInfo();  // Save user information
//     listenToMessages();
//   }
//
//   // Save user's name and email in Firebase under the "users" node
//   void saveUserInfo() {
//     if (currentUser != null) {
//       final userEmail = currentUser!.email ?? "No Email";
//       final userName = userEmail.split('@')[0];
//
//       usersRef.child(currentUser!.uid).set({
//         "username": userName,
//         "email": userEmail,
//       });
//     }
//   }
//
//   // Listen for incoming messages
//   void listenToMessages() {
//     messagesRef.child(currentUser!.uid).child("messages").onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
//       final loadedMessages = data.values
//           .map((msg) => Map<String, dynamic>.from(msg))
//           .toList();
//       setState(() {
//         messages = loadedMessages;
//       });
//     });
//   }
//
//   // Send message to the admin
//   void sendMessage() {
//     if (messageController.text.isEmpty) return;
//     final message = {
//       "message": messageController.text,
//       "sender": "user",
//       "timestamp": DateTime.now().toIso8601String(),
//     };
//
//     messagesRef.child(currentUser!.uid).child("messages").push().set(message);
//     messageController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Help & Support")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final msg = messages[index];
//                 final isUser = msg['sender'] == 'user';
//                 return Align(
//                   alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     decoration: BoxDecoration(
//                       color: isUser ? Colors.blue[100] : Colors.grey[300],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(msg['message']),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: messageController,
//                     decoration: InputDecoration(
//                       hintText: "Type your message...",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class HelpSupportScreen extends StatefulWidget {
//   @override
//   _HelpSupportScreenState createState() => _HelpSupportScreenState();
// }
//
// class _HelpSupportScreenState extends State<HelpSupportScreen> {
//   final User? currentUser = FirebaseAuth.instance.currentUser;
//   final DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
//   final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
//   final TextEditingController messageController = TextEditingController();
//
//   List<Map<String, dynamic>> messages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     saveUserInfo();  // Save user information
//     listenToMessages();
//   }
//
//   // Save user's name and email in Firebase under the "users" node
//   void saveUserInfo() {
//     if (currentUser != null) {
//       final userEmail = currentUser!.email ?? "No Email";
//       final userName = userEmail.split('@')[0];
//
//       usersRef.child(currentUser!.uid).set({
//         "username": userName,
//         "email": userEmail,
//       });
//     }
//   }
//
//   // Listen for incoming messages
//   void listenToMessages() {
//     messagesRef.child(currentUser!.uid).child("messages").onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
//       final loadedMessages = data.values
//           .map((msg) => Map<String, dynamic>.from(msg))
//           .toList();
//       setState(() {
//         messages = loadedMessages;
//       });
//     });
//   }
//
//   // Send message to the admin
//   void sendMessage() {
//     if (messageController.text.isEmpty) return;
//     final message = {
//       "message": messageController.text,
//       "sender": "user",
//       "timestamp": DateTime.now().toIso8601String(),
//     };
//
//     messagesRef.child(currentUser!.uid).child("messages").push().set(message);
//     messageController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Help & Support")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final msg = messages[index];
//                 final isUser = msg['sender'] == 'user';
//                 return Align(
//                   alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     decoration: BoxDecoration(
//                       color: isUser ? Colors.blue[100] : Colors.grey[300],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(msg['message']),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: messageController,
//                     decoration: InputDecoration(
//                       hintText: "Type your message...",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class HelpSupportScreen extends StatefulWidget {
//   @override
//   _HelpSupportScreenState createState() => _HelpSupportScreenState();
// }
//
// class _HelpSupportScreenState extends State<HelpSupportScreen> {
//   final User? currentUser = FirebaseAuth.instance.currentUser;
//   final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
//   final TextEditingController messageController = TextEditingController();
//
//   List<Map<String, dynamic>> messages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     listenToMessages();
//   }
//
//   void listenToMessages() {
//     messagesRef.child(currentUser!.uid).child("messages").onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
//       final loadedMessages = data.values
//           .map((msg) => Map<String, dynamic>.from(msg))
//           .toList();
//       setState(() {
//         messages = loadedMessages;
//       });
//     });
//   }
//
//   void sendMessage() {
//     if (messageController.text.isEmpty) return;
//
//     // Extract user data
//     final String userEmail = currentUser!.email ?? 'No Email';
//     final String userName = userEmail.split('@')[0]; // Extract name from email
//
//     final message = {
//       "message": messageController.text,
//       "sender": "user",
//       "email": userEmail,
//       "username": userName,
//       "timestamp": DateTime.now().toIso8601String(),
//     };
//
//     messagesRef.child(currentUser!.uid).child("messages").push().set(message);
//     messageController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Help & Support")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final msg = messages[index];
//                 final isUser = msg['sender'] == 'user';
//                 return Align(
//                   alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     decoration: BoxDecoration(
//                       color: isUser ? Colors.blue[100] : Colors.grey[300],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(msg['message']),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: messageController,
//                     decoration: InputDecoration(
//                       hintText: "Type your message...",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class HelpSupportScreen extends StatefulWidget {
//   @override
//   _HelpSupportScreenState createState() => _HelpSupportScreenState();
// }
//
// class _HelpSupportScreenState extends State<HelpSupportScreen> {
//   final User? currentUser = FirebaseAuth.instance.currentUser;
//   final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
//   final TextEditingController messageController = TextEditingController();
//
//   List<Map<String, dynamic>> messages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     listenToMessages();
//   }
//
//   void listenToMessages() {
//     messagesRef.child(currentUser!.uid).child("messages").onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
//       final loadedMessages = data.values
//           .map((msg) => Map<String, dynamic>.from(msg))
//           .toList();
//       setState(() {
//         messages = loadedMessages;
//       });
//     });
//   }
//
//   void sendMessage() {
//     if (messageController.text.isEmpty) return;
//
//     final message = {
//       "message": messageController.text,
//       "sender": "user",
//       "email": currentUser!.email,
//       "username": currentUser!.displayName ?? 'Unknown User',
//       "timestamp": DateTime.now().toIso8601String(),
//     };
//
//     messagesRef.child(currentUser!.uid).child("messages").push().set(message);
//     messageController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Help & Support")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final msg = messages[index];
//                 final isUser = msg['sender'] == 'user';
//                 return Align(
//                   alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     decoration: BoxDecoration(
//                       color: isUser ? Colors.blue[100] : Colors.grey[300],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(msg['message']),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: messageController,
//                     decoration: InputDecoration(
//                       hintText: "Type your message...",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class HelpSupportScreen extends StatefulWidget {
//   @override
//   _HelpSupportScreenState createState() => _HelpSupportScreenState();
// }
//
// class _HelpSupportScreenState extends State<HelpSupportScreen> {
//   final User? currentUser = FirebaseAuth.instance.currentUser;
//   final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
//   final TextEditingController messageController = TextEditingController();
//
//   List<Map<String, dynamic>> messages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     listenToMessages();
//   }
//
//   void listenToMessages() {
//     messagesRef.child(currentUser!.uid).child("messages").onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
//       final loadedMessages = data.values
//           .map((msg) => Map<String, dynamic>.from(msg))
//           .toList();
//       setState(() {
//         messages = loadedMessages;
//       });
//     });
//   }
//
//   void sendMessage() {
//     if (messageController.text.isEmpty) return;
//     final message = {
//       "message": messageController.text,
//       "sender": "user",
//       "timestamp": DateTime.now().toIso8601String(),
//     };
//     messagesRef.child(currentUser!.uid).child("messages").push().set(message);
//     messageController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Help & Support")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final msg = messages[index];
//                 final isUser = msg['sender'] == 'user';
//                 return Align(
//                   alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     decoration: BoxDecoration(
//                       color: isUser ? Colors.blue[100] : Colors.grey[300],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(msg['message']),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: messageController,
//                     decoration: InputDecoration(
//                       hintText: "Type your message...",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class HelpSupportScreen extends StatefulWidget {
//   @override
//   _HelpSupportScreenState createState() => _HelpSupportScreenState();
// }
//
// class _HelpSupportScreenState extends State<HelpSupportScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final DatabaseReference _messagesRef =
//   FirebaseDatabase.instance.ref().child("support_messages");
//
//   List<Map<String, dynamic>> messages = [];
//   User? currentUser;
//
//   @override
//   void initState() {
//     super.initState();
//     currentUser = _auth.currentUser;
//     _listenToMessages();
//   }
//
//   /// Listens to messages in real-time from Firebase.
//   void _listenToMessages() {
//     if (currentUser != null) {
//       _messagesRef
//           .child(currentUser!.uid)
//           .child("messages")
//           .onValue
//           .listen((event) {
//         final data = event.snapshot.value;
//
//         if (data != null && data is Map) {
//           // Convert the Map data to a List of messages.
//           final List<Map<String, dynamic>> loadedMessages =
//           (data.values as Iterable).map((e) => Map<String, dynamic>.from(e)).toList();
//
//           setState(() {
//             messages = loadedMessages;
//           });
//         }
//       });
//     }
//   }
//
//   /// Sends a message to Firebase.
//   void _sendMessage(String message) {
//     if (message.isEmpty || currentUser == null) return;
//
//     final newMessage = {
//       "sender": "user",
//       "message": message,
//       "timestamp": DateTime.now().toIso8601String(),
//     };
//
//     _messagesRef.child(currentUser!.uid).child("messages").push().set(newMessage);
//     _messageController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Help & Support")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final message = messages[index];
//                 final isUserMessage = message['sender'] == 'user';
//
//                 return Align(
//                   alignment:
//                   isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     padding: EdgeInsets.all(12),
//                     margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                     decoration: BoxDecoration(
//                       color: isUserMessage ? Colors.blue : Colors.grey[300],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(
//                       message['message'],
//                       style: TextStyle(
//                           color: isUserMessage ? Colors.white : Colors.black),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: "Type your message...",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     _sendMessage(_messageController.text);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// // import 'package:flutter/material.dart';
// //
// // class HelpSupportScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Help & Support"),
// //
// //       ),
// //       body: Padding(
// //         padding: EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             SizedBox(height: 15,),
// //             Text("Frequently Asked Questions", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20)),
// //             SizedBox(height: 16),
// //             Divider(),
// //             ListTile(
// //               title: Text("How can I reset my password?"),
// //               trailing: Icon(Icons.arrow_forward),
// //               onTap: () {
// //                 // Handle navigation to a detailed FAQ or guide
// //               },
// //             ),
// //             ListTile(
// //               trailing: Icon(Icons.arrow_forward),
// //               title: Text("How do I redeem my credits?"),
// //               subtitle: Text("Learn how to use your credits to redeem gifts."),
// //               onTap: () {
// //                 // Add your onTap functionality here
// //                 print("Tapped on redeeming credits");
// //               },
// //             ),
// //             ListTile(
// //               trailing: Icon(Icons.arrow_forward),
// //               title: Text("What if I forget my password?"),
// //               subtitle: Text("Instructions on resetting your password."),
// //               onTap: () {
// //                 // Add your onTap functionality here
// //                 print("Tapped on forgetting password");
// //               },
// //             ),
// //             ListTile(
// //               trailing: Icon(Icons.arrow_forward),
// //               title: Text("How can I contact customer support?"),
// //               subtitle: Text("Get in touch with our support team for assistance."),
// //               onTap: () {
// //                 // Add your onTap functionality here
// //                 print("Tapped on contacting support");
// //               },
// //             ),
// //             ListTile(
// //               trailing: Icon(Icons.arrow_forward),
// //                 title: Text("What items can I redeem with my credits?"),
// //               subtitle: Text("A list of available items for redemption."),
// //               onTap: () {
// //                 // Add your onTap functionality here
// //                 print("Tapped on items for redemption");
// //               },
// //             ),
// //             ListTile(
// //               title: Text("How to use the gift card?"),
// //               trailing: Icon(Icons.arrow_forward),
// //               onTap: () {
// //                 // Handle navigation to a detailed FAQ or guide
// //               },
// //             ),
// //             // Add more FAQ items as needed
// //             Spacer(),
// //             ElevatedButton(
// //
// //               onPressed: () {
// //                 // Navigate to contact support
// //               },
// //               child: Padding(
// //
// //                 padding: const EdgeInsets.fromLTRB(10,20,10,20),
// //                 child: Text("Contact Support"),
// //               ),
// //               style: ElevatedButton.styleFrom(
// //                 primary: Colors.black38,
// //                 padding: EdgeInsets.symmetric(horizontal: 24),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
