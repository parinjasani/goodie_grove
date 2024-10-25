import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final DatabaseReference messagesRef =
  FirebaseDatabase.instance.ref().child("support_messages");
  Map<String, Map<String, dynamic>> userChats = {};

  @override
  void initState() {
    super.initState();
    fetchUserChats();
  }

  void fetchUserChats() {
    messagesRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      Map<String, Map<String, dynamic>> loadedChats = {};

      data.forEach((uid, value) {
        final info = value['info'] as Map<dynamic, dynamic>? ?? {};
        final messages = value['messages'] as Map<dynamic, dynamic>? ?? {};

        loadedChats[uid] = {
          "username": info["username"] ?? "Unknown",
          "email": info["email"] ?? "No Email",
          "latestMessage": messages.isNotEmpty
              ? (messages.values.last as Map)["message"]
              : "No messages yet",
        };
      });

      setState(() {
        userChats = loadedChats;
      });
    });
  }

  void deleteChat(String userId) {
    messagesRef.child(userId).remove();
    setState(() {
      userChats.remove(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(title: Text("Admin Help & Support")),
      body: ListView.builder(
        itemCount: userChats.length,
        itemBuilder: (context, index) {
          final uid = userChats.keys.elementAt(index);
          final user = userChats[uid]!;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white),
              child: ListTile(
                title: Row(
                  children: [
                    Text(user["username"],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                    SizedBox(width: 7,),
                    Text(user["email"],style: TextStyle(color: Colors.black,)),
                  ],
                ),
                subtitle: Text(user["latestMessage"],style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    SizedBox(width: 18,),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.black),
                      onPressed: () => deleteChat(uid),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminChatScreen(userId: uid),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
class AdminChatScreen extends StatefulWidget {
  final String userId;

  AdminChatScreen({required this.userId});

  @override
  _AdminChatScreenState createState() => _AdminChatScreenState();
}

class _AdminChatScreenState extends State<AdminChatScreen> {
  final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
  final TextEditingController messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    listenToMessages();
  }

  void listenToMessages() {
    messagesRef.child(widget.userId).child("messages").orderByChild("timestamp").onValue.listen((event) {
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
      "sender": "admin",
      "timestamp": DateTime.now().millisecondsSinceEpoch,
    };

    messagesRef.child(widget.userId).child("messages").push().set(message);
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(title: Text("Chat with User")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isAdmin = msg['sender'] == 'admin';

                return Align(
                  alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isAdmin ? Colors.green[100] : Colors.blue[100],
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
                  child: TextField(style: TextStyle(color: Colors.white),
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send,color: Colors.white),
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
// import 'package:firebase_database/firebase_database.dart';
//
// class FeedbackScreen extends StatefulWidget {
//   @override
//   _FeedbackScreenState createState() => _FeedbackScreenState();
// }
//
// class _FeedbackScreenState extends State<FeedbackScreen> {
//   final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
//   Map<String, Map<String, dynamic>> userChats = {};
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserChats();
//   }
//
//   void fetchUserChats() {
//     messagesRef.onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
//       Map<String, Map<String, dynamic>> loadedChats = {};
//
//       data.forEach((uid, value) {
//         final info = value['info'] as Map<dynamic, dynamic>? ?? {};
//         final messages = value['messages'] as Map<dynamic, dynamic>? ?? {};
//
//         loadedChats[uid] = {
//           "username": info["username"] ?? "Unknown",
//           "email": info["email"] ?? "No Email",
//           "latestMessage": messages.isNotEmpty
//               ? (messages.values.last as Map)["message"]
//               : "No messages yet",
//         };
//       });
//
//       setState(() {
//         userChats = loadedChats;
//       });
//     });
//   }
//
//   void deleteChat(String userId) {
//     messagesRef.child(userId).remove();
//     setState(() {
//       userChats.remove(userId);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Admin Help & Support")),
//       body: ListView.builder(
//         itemCount: userChats.length,
//         itemBuilder: (context, index) {
//           final uid = userChats.keys.elementAt(index);
//           final user = userChats[uid]!;
//
//           return ListTile(
//             title: Text(user["username"]),
//             subtitle: Text(user["email"]),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(user["latestMessage"]),
//                 IconButton(
//                   icon: Icon(Icons.delete, color: Colors.red),
//                   onPressed: () => deleteChat(uid),
//                 ),
//               ],
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => AdminChatScreen(userId: uid),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class AdminChatScreen extends StatefulWidget {
//   final String userId;
//
//   AdminChatScreen({required this.userId});
//
//   @override
//   _AdminChatScreenState createState() => _AdminChatScreenState();
// }
//
// class _AdminChatScreenState extends State<AdminChatScreen> {
//   final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
//   final TextEditingController messageController = TextEditingController();
//   List<Map<String, dynamic>> messages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     listenToMessages();
//   }
//
//   void listenToMessages() {
//     messagesRef.child(widget.userId).child("messages").orderByChild("timestamp").onValue.listen((event) {
//       if (event.snapshot.value != null) {
//         final data = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
//         final loadedMessages = data.values
//             .map((msg) => Map<String, dynamic>.from(msg))
//             .toList()
//           ..sort((a, b) => a['timestamp'].compareTo(b['timestamp']));
//
//         setState(() {
//           messages = loadedMessages;
//         });
//       }
//     });
//   }
//
//   void sendMessage() {
//     if (messageController.text.isEmpty) return;
//
//     final message = {
//       "message": messageController.text,
//       "sender": "admin",
//       "timestamp": DateTime.now().millisecondsSinceEpoch,
//     };
//
//     messagesRef.child(widget.userId).child("messages").push().set(message);
//     messageController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Chat with User")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final msg = messages[index];
//                 final isAdmin = msg['sender'] == 'admin';
//
//                 return Align(
//                   alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: isAdmin ? Colors.green[100] : Colors.blue[100],
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
// import 'package:firebase_database/firebase_database.dart';
//
// class FeedbackScreen extends StatefulWidget {
//   @override
//   _FeedbackScreenState createState() => _FeedbackScreenState();
// }
//
// class _FeedbackScreenState extends State<FeedbackScreen> {
//   final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
//   final DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
//
//   Map<String, List<Map<String, dynamic>>> allUserMessages = {};
//   Map<String, Map<String, String>> userInfo = {};
//
//   @override
//   void initState() {
//     super.initState();
//     fetchMessages();
//   }
//
//   void fetchMessages() async {
//     messagesRef.onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
//       Map<String, List<Map<String, dynamic>>> loadedMessages = {};
//
//       data.forEach((uid, value) async {
//         final userMessages = value['messages'] as Map<dynamic, dynamic>? ?? {};
//         loadedMessages[uid] = userMessages.values
//             .map((msg) => Map<String, dynamic>.from(msg))
//             .toList();
//
//         final userSnapshot = await usersRef.child(uid).get();
//         final userData = userSnapshot.value as Map<dynamic, dynamic>? ?? {};
//         userInfo[uid] = {
//           "username": userData["username"] ?? "Unknown",
//           "email": userData["email"] ?? "No Email",
//         };
//
//         setState(() {
//           allUserMessages = loadedMessages;
//         });
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Admin Support Panel")),
//       body: ListView.builder(
//         itemCount: allUserMessages.keys.length,
//         itemBuilder: (context, index) {
//           final uid = allUserMessages.keys.elementAt(index);
//           final userMessages = allUserMessages[uid] ?? [];
//           final latestMessage = userMessages.isNotEmpty ? userMessages.last : null;
//
//           final userName = userInfo[uid]?["username"] ?? "Unknown User";
//           final userEmail = userInfo[uid]?["email"] ?? "No Email";
//
//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: ListTile(
//               title: Text('$userName ($userEmail)'),
//               subtitle: Text('Latest Message: ${latestMessage?['message'] ?? 'No message'}'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => UserChatScreen(uid: uid),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class UserChatScreen extends StatefulWidget {
//   final String uid;
//
//   UserChatScreen({required this.uid});
//
//   @override
//   _UserChatScreenState createState() => _UserChatScreenState();
// }
//
// class _UserChatScreenState extends State<UserChatScreen> {
//   final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
//   final TextEditingController replyController = TextEditingController();
//   List<Map<String, dynamic>> chatMessages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     loadChatMessages();
//   }
//
//   void loadChatMessages() {
//     messagesRef.child(widget.uid).child("messages").orderByChild("timestamp").onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
//       final messages = data.values.map((msg) => Map<String, dynamic>.from(msg)).toList()
//         ..sort((a, b) => a['timestamp'].compareTo(b['timestamp'])); // Maintain order
//
//       setState(() {
//         chatMessages = messages; // Update chat messages state
//       });
//     });
//   }
//
//   void sendReply() {
//     if (replyController.text.isEmpty) return;
//     final message = {
//       "message": replyController.text,
//       "sender": "admin",
//       "timestamp": DateTime.now().millisecondsSinceEpoch,
//     };
//     messagesRef.child(widget.uid).child("messages").push().set(message);
//     replyController.clear();
//   }
//
//   void deleteMessage(String messageId) {
//     messagesRef.child(widget.uid).child("messages").child(messageId).remove();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Chat with User")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: chatMessages.length,
//               itemBuilder: (context, index) {
//                 final msg = chatMessages[index];
//                 final isAdmin = msg['sender'] == 'admin';
//                 return Dismissible(
//                   key: Key(msg['timestamp'].toString()),
//                   onDismissed: (direction) {
//                     deleteMessage(msg['timestamp'].toString()); // Call delete function
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Message deleted")));
//                   },
//                   child: Align(
//                     alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
//                     child: Container(
//                       padding: EdgeInsets.all(10),
//                       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                       decoration: BoxDecoration(
//                         color: isAdmin ? Colors.green[100] : Colors.blue[100],
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(msg['message']),
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
//                     controller: replyController,
//                     decoration: InputDecoration(
//                       hintText: "Type your reply...",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: sendReply,
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
// import 'package:firebase_database/firebase_database.dart';
//
// class FeedbackScreen extends StatefulWidget {
//   @override
//   _FeedbackScreenState createState() => _FeedbackScreenState();
// }
//
// class _FeedbackScreenState extends State<FeedbackScreen> {
//   final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
//   final DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
//
//   Map<String, List<Map<String, dynamic>>> allUserMessages = {};
//   Map<String, Map<String, String>> userInfo = {};
//
//   @override
//   void initState() {
//     super.initState();
//     fetchMessages();
//   }
//   void listenToMessages() {
//     messagesRef
//         .child(widget.uid)
//         .child("messages")
//         .orderByChild("timestamp") // This ensures that messages are sorted by timestamp.
//         .onValue
//         .listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
//       final loadedMessages = data.values
//           .map((msg) => Map<String, dynamic>.from(msg))
//           .toList()
//         ..sort((a, b) => a['timestamp'].compareTo(b['timestamp'])); // Sort by timestamp
//
//       setState(() {
//         messages = loadedMessages; // Update the state with fetched messages.
//       });
//     });
//   }
//
//   void fetchMessages() async {
//     messagesRef.onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
//       Map<String, List<Map<String, dynamic>>> loadedMessages = {};
//
//       data.forEach((uid, value) async {
//         final userMessages = value['messages'] as Map<dynamic, dynamic>? ?? {};
//         loadedMessages[uid] = userMessages.values
//             .map((msg) => Map<String, dynamic>.from(msg))
//             .toList();
//
//         final userSnapshot = await usersRef.child(uid).get();
//         final userData = userSnapshot.value as Map<dynamic, dynamic>? ?? {};
//         userInfo[uid] = {
//           "username": userData["username"] ?? "Unknown",
//           "email": userData["email"] ?? "No Email",
//         };
//
//         setState(() {
//           allUserMessages = loadedMessages;
//         });
//       });
//     });
//   }
//
//   void deleteChat(String uid) {
//     messagesRef.child(uid).remove();
//     setState(() {
//       allUserMessages.remove(uid);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Admin Support Panel")),
//       body: ListView.builder(
//         itemCount: allUserMessages.keys.length,
//         itemBuilder: (context, index) {
//           final uid = allUserMessages.keys.elementAt(index);
//           final userMessages = allUserMessages[uid] ?? [];
//           final latestMessage = userMessages.isNotEmpty ? userMessages.last : null;
//
//           final userName = userInfo[uid]?["username"] ?? "Unknown User";
//           final userEmail = userInfo[uid]?["email"] ?? "No Email";
//
//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: ListTile(
//               title: Text('$userName ($userEmail)'),
//               subtitle: Text('Latest Message: ${latestMessage?['message'] ?? 'No message'}'),
//               trailing: IconButton(
//                 icon: Icon(Icons.delete, color: Colors.red),
//                 onPressed: () => deleteChat(uid),
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => UserChatScreen(uid: uid),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class UserChatScreen extends StatefulWidget {
//   final String uid;
//
//   UserChatScreen({required this.uid});
//
//   @override
//   _UserChatScreenState createState() => _UserChatScreenState();
// }
//
// class _UserChatScreenState extends State<UserChatScreen> {
//   final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
//   final TextEditingController replyController = TextEditingController();
//
//   List<Map<String, dynamic>> chatMessages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     loadChatMessages();
//   }
//
//   void loadChatMessages() {
//     messagesRef.child(widget.uid).child("messages").orderByChild("timestamp").onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
//       final messages = data.values
//           .map((msg) => Map<String, dynamic>.from(msg))
//           .toList()
//         ..sort((a, b) => a['timestamp'].compareTo(b['timestamp'])); // Maintain order
//
//       setState(() {
//         chatMessages = messages; // Update the state with loaded messages.
//       });
//     });
//   }
//
//   // void loadChatMessages() {
//   //   messagesRef.child(widget.uid).child("messages").orderByChild("timestamp").onValue.listen((event) {
//   //     final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
//   //     final messages = data.values
//   //         .map((msg) => Map<String, dynamic>.from(msg))
//   //         .toList()
//   //       ..sort((a, b) => a['timestamp'].compareTo(b['timestamp'])); // Maintain order
//   //
//   //     setState(() {
//   //       chatMessages = messages;
//   //     });
//   //   });
//   // }
//
//   void sendReply() {
//     if (replyController.text.isEmpty) return;
//     final message = {
//       "message": replyController.text,
//       "sender": "admin",
//       "timestamp": DateTime.now().millisecondsSinceEpoch,
//     };
//     messagesRef.child(widget.uid).child("messages").push().set(message);
//     replyController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Chat with User")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: chatMessages.length,
//               itemBuilder: (context, index) {
//                 final msg = chatMessages[index];
//                 final isAdmin = msg['sender'] == 'admin';
//                 return Align(
//                   alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     decoration: BoxDecoration(
//                       color: isAdmin ? Colors.green[100] : Colors.blue[100],
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
//                     controller: replyController,
//                     decoration: InputDecoration(
//                       hintText: "Type your reply...",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: sendReply,
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
// import 'package:firebase_database/firebase_database.dart';
//
// class FeedbackScreen extends StatefulWidget {
//   @override
//   _FeedbackScreenState createState() => _FeedbackScreenState();
// }
//
// class _FeedbackScreenState extends State<FeedbackScreen> {
//   final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
//   final DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
//
//   Map<String, List<Map<String, dynamic>>> allUserMessages = {};
//   Map<String, Map<String, String>> userInfo = {};
//
//   @override
//   void initState() {
//     super.initState();
//     fetchMessages();
//   }
//
//   void fetchMessages() async {
//     messagesRef.onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
//       Map<String, List<Map<String, dynamic>>> loadedMessages = {};
//
//       data.forEach((uid, value) async {
//         final userMessages = value['messages'] as Map<dynamic, dynamic>? ?? {};
//         loadedMessages[uid] = userMessages.values
//             .map((msg) => Map<String, dynamic>.from(msg))
//             .toList();
//
//         final userSnapshot = await usersRef.child(uid).get();
//         final userData = userSnapshot.value as Map<dynamic, dynamic>? ?? {};
//         userInfo[uid] = {
//           "username": userData["username"] ?? "Unknown",
//           "email": userData["email"] ?? "No Email",
//         };
//
//         setState(() {
//           allUserMessages = loadedMessages;
//         });
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Admin Support Panel")),
//       body: ListView.builder(
//         itemCount: allUserMessages.keys.length,
//         itemBuilder: (context, index) {
//           final uid = allUserMessages.keys.elementAt(index);
//           final userMessages = allUserMessages[uid] ?? [];
//           final latestMessage = userMessages.isNotEmpty ? userMessages.last : null;
//
//           final userName = userInfo[uid]?["username"] ?? "Unknown User";
//           final userEmail = userInfo[uid]?["email"] ?? "No Email";
//
//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: ListTile(
//               title: Text('$userName ($userEmail)'),
//               subtitle: Text('Latest Message: ${latestMessage?['message'] ?? 'No message'}'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => UserChatScreen(uid: uid),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class UserChatScreen extends StatefulWidget {
//   final String uid;
//
//   UserChatScreen({required this.uid});
//
//   @override
//   _UserChatScreenState createState() => _UserChatScreenState();
// }
//
// class _UserChatScreenState extends State<UserChatScreen> {
//   final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
//   final TextEditingController replyController = TextEditingController();
//
//   List<Map<String, dynamic>> chatMessages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     loadChatMessages();
//   }
//
//   void loadChatMessages() {
//     messagesRef.child(widget.uid).child("messages").orderByChild("timestamp").onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
//       final messages = data.values.map((msg) => Map<String, dynamic>.from(msg)).toList()
//         ..sort((a, b) => a['timestamp'].compareTo(b['timestamp'])); // Maintain order
//
//       setState(() {
//         chatMessages = messages;
//       });
//     });
//   }
//
//   void sendReply() {
//     if (replyController.text.isEmpty) return;
//     final message = {
//       "message": replyController.text,
//       "sender": "admin",
//       "timestamp": DateTime.now().millisecondsSinceEpoch,
//     };
//     messagesRef.child(widget.uid).child("messages").push().set(message);
//     replyController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Chat with User")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: chatMessages.length,
//               itemBuilder: (context, index) {
//                 final msg = chatMessages[index];
//                 final isAdmin = msg['sender'] == 'admin';
//                 return Align(
//                   alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     decoration: BoxDecoration(
//                       color: isAdmin ? Colors.green[100] : Colors.blue[100],
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
//                     controller: replyController,
//                     decoration: InputDecoration(
//                       hintText: "Type your reply...",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: sendReply,
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
// import 'package:firebase_database/firebase_database.dart';
//
// class FeedbackScreen extends StatefulWidget {
//   @override
//   _FeedbackScreenState createState() => _FeedbackScreenState();
// }
//
// class _FeedbackScreenState extends State<FeedbackScreen> {
//   final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
//   final DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
//
//   Map<String, List<Map<String, dynamic>>> allUserMessages = {};
//   Map<String, Map<String, String>> userInfo = {}; // Store user info
//
//   @override
//   void initState() {
//     super.initState();
//     fetchMessages();
//   }
//
//   // Fetch all messages and user data
//   void fetchMessages() async {
//     messagesRef.onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
//       Map<String, List<Map<String, dynamic>>> loadedMessages = {};
//
//       data.forEach((uid, value) async {
//         final userMessages = value['messages'] as Map<dynamic, dynamic>? ?? {};
//         loadedMessages[uid] = userMessages.values
//             .map((msg) => Map<String, dynamic>.from(msg))
//             .toList();
//
//         // Fetch user info (name and email) for each user
//         final userSnapshot = await usersRef.child(uid).get();
//         final userData = userSnapshot.value as Map<dynamic, dynamic>? ?? {};
//         userInfo[uid] = {
//           "username": userData["username"] ?? "Unknown",
//           "email": userData["email"] ?? "No Email",
//         };
//
//         setState(() {
//           allUserMessages = loadedMessages;
//         });
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Admin Support Panel")),
//       body: ListView.builder(
//         itemCount: allUserMessages.keys.length,
//         itemBuilder: (context, index) {
//           final uid = allUserMessages.keys.elementAt(index);
//           final userMessages = allUserMessages[uid] ?? [];
//           final latestMessage = userMessages.isNotEmpty ? userMessages.last : null;
//
//           final userName = userInfo[uid]?["username"] ?? "Unknown User";
//           final userEmail = userInfo[uid]?["email"] ?? "No Email";
//
//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: ListTile(
//               title: Text('$userName ($userEmail)'),
//               subtitle: Text('Latest Message: ${latestMessage?['message'] ?? 'No message'}'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => UserChatScreen(uid: uid, messages: userMessages),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class UserChatScreen extends StatelessWidget {
//   final String uid;
//   final List<Map<String, dynamic>> messages;
//
//   UserChatScreen({required this.uid, required this.messages});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Chat with User")),
//       body: ListView.builder(
//         itemCount: messages.length,
//         itemBuilder: (context, index) {
//           final msg = messages[index];
//           final isAdmin = msg['sender'] == 'admin';
//           return Align(
//             alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
//             child: Container(
//               padding: EdgeInsets.all(10),
//               margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//               decoration: BoxDecoration(
//                 color: isAdmin ? Colors.green[100] : Colors.blue[100],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(msg['message']),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class FeedbackScreen extends StatefulWidget {
//   @override
//   _FeedbackScreenState createState() => _FeedbackScreenState();
// }
//
// class _FeedbackScreenState extends State<FeedbackScreen> {
//   final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
//
//   Map<String, List<Map<String, dynamic>>> allUserMessages = {};
//
//   @override
//   void initState() {
//     super.initState();
//     fetchMessages();
//   }
//
//   void fetchMessages() {
//     messagesRef.onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
//       Map<String, List<Map<String, dynamic>>> loadedMessages = {};
//
//       data.forEach((uid, value) {
//         final userMessages = value['messages'] as Map<dynamic, dynamic>? ?? {};
//         loadedMessages[uid] = userMessages.values
//             .map((msg) => Map<String, dynamic>.from(msg))
//             .toList();
//       });
//
//       setState(() {
//         allUserMessages = loadedMessages;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Admin Support Panel")),
//       body: ListView.builder(
//         itemCount: allUserMessages.keys.length,
//         itemBuilder: (context, index) {
//           final uid = allUserMessages.keys.elementAt(index);
//           final userMessages = allUserMessages[uid] ?? [];
//           final latestMessage = userMessages.isNotEmpty ? userMessages.last : null;
//
//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: ListTile(splashColor: Colors.black54,
//               title: Text(latestMessage?['username'] ?? 'Unknown User',style: TextStyle(color: Colors.black54)),
//               subtitle: Text(latestMessage?['email'] ?? 'No Email Provided',style: TextStyle(color: Colors.black54)),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => UserChatScreen(uid: uid, messages: userMessages),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class UserChatScreen extends StatelessWidget {
//   final String uid;
//   final List<Map<String, dynamic>> messages;
//
//   UserChatScreen({required this.uid, required this.messages});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Chat with User")),
//       body: ListView.builder(
//         itemCount: messages.length,
//         itemBuilder: (context, index) {
//           final msg = messages[index];
//           final isAdmin = msg['sender'] == 'admin';
//           return Align(
//             alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
//             child: Container(
//               padding: EdgeInsets.all(10),
//               margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//               decoration: BoxDecoration(
//                 color: isAdmin ? Colors.green[100] : Colors.blue[100],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(msg['message']),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class FeedbackScreen extends StatefulWidget {
//   @override
//   _FeedbackScreenState createState() => _FeedbackScreenState();
// }
//
// class _FeedbackScreenState extends State<FeedbackScreen> {
//   final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
//   Map<String, dynamic> userMessages = {};
//   String? selectedUserUid;
//   List<Map<String, dynamic>> chatMessages = [];
//   final TextEditingController replyController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserMessages();
//   }
//
//   Future<void> fetchUserMessages() async {
//     messagesRef.onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
//       setState(() {
//         userMessages = data.map((key, value) => MapEntry(key, Map<String, dynamic>.from(value)));
//       });
//     });
//   }
//
//   void loadChatMessages(String uid) {
//     final user = userMessages[uid];
//     final messages = (user['messages'] as Map).values
//         .map((msg) => Map<String, dynamic>.from(msg))
//         .toList();
//     setState(() {
//       selectedUserUid = uid;
//       chatMessages = messages;
//     });
//   }
//
//   void sendReply() {
//     if (replyController.text.isEmpty || selectedUserUid == null) return;
//     final message = {
//       "message": replyController.text,
//       "sender": "admin",
//       "timestamp": DateTime.now().toIso8601String(),
//     };
//     messagesRef.child(selectedUserUid!).child("messages").push().set(message);
//     replyController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Admin Support Panel")),
//       body: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: ListView(
//               children: userMessages.entries.map((entry) {
//                 final uid = entry.key;
//                 final username = entry.value['username'];
//                 return ListTile(
//                   title: Text(username ?? "Unknown User"),
//                   onTap: () => loadChatMessages(uid),
//                 );
//               }).toList(),
//             ),
//           ),
//           VerticalDivider(),
//           Expanded(
//             flex: 3,
//             child: Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: chatMessages.length,
//                     itemBuilder: (context, index) {
//                       final msg = chatMessages[index];
//                       final isAdmin = msg['sender'] == 'admin';
//                       return Align(
//                         alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
//                         child: Container(
//                           padding: EdgeInsets.all(10),
//                           margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                           decoration: BoxDecoration(
//                             color: isAdmin ? Colors.blue[100] : Colors.grey[300],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(msg['message']),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: replyController,
//                           decoration: InputDecoration(
//                             hintText: "Type your reply...",
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.send),
//                         onPressed: sendReply,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // class FeedbackScreen extends StatelessWidget {
// //   const FeedbackScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return const Center(
// //       child: Text(
// //         "feedback",style: TextStyle(fontWeight: FontWeight.bold),
// //       ),
// //     );
// //   }
// // }
