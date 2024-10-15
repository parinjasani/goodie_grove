import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child("support_messages");
  Map<String, dynamic> userMessages = {};
  String? selectedUserUid;
  List<Map<String, dynamic>> chatMessages = [];
  final TextEditingController replyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserMessages();
  }

  Future<void> fetchUserMessages() async {
    messagesRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      setState(() {
        userMessages = data.map((key, value) => MapEntry(key, Map<String, dynamic>.from(value)));
      });
    });
  }

  void loadChatMessages(String uid) {
    final user = userMessages[uid];
    final messages = (user['messages'] as Map).values
        .map((msg) => Map<String, dynamic>.from(msg))
        .toList();
    setState(() {
      selectedUserUid = uid;
      chatMessages = messages;
    });
  }

  void sendReply() {
    if (replyController.text.isEmpty || selectedUserUid == null) return;
    final message = {
      "message": replyController.text,
      "sender": "admin",
      "timestamp": DateTime.now().toIso8601String(),
    };
    messagesRef.child(selectedUserUid!).child("messages").push().set(message);
    replyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Support Panel")),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: ListView(
              children: userMessages.entries.map((entry) {
                final uid = entry.key;
                final username = entry.value['username'];
                return ListTile(
                  title: Text(username ?? "Unknown User"),
                  onTap: () => loadChatMessages(uid),
                );
              }).toList(),
            ),
          ),
          VerticalDivider(),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: chatMessages.length,
                    itemBuilder: (context, index) {
                      final msg = chatMessages[index];
                      final isAdmin = msg['sender'] == 'admin';
                      return Align(
                        alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: isAdmin ? Colors.blue[100] : Colors.grey[300],
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
                          controller: replyController,
                          decoration: InputDecoration(
                            hintText: "Type your reply...",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: sendReply,
                      ),
                    ],
                  ),
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
//   final DatabaseReference _messagesRef =
//   FirebaseDatabase.instance.ref().child("support_messages");
//
//   List<Map<String, dynamic>> userMessages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserMessages();
//   }
//
//   /// Fetches all user messages from Firebase.
//   Future<void> _fetchUserMessages() async {
//     final snapshot = await _messagesRef.once();
//
//     if (snapshot.snapshot.value != null) {
//       final data = snapshot.snapshot.value;
//
//       if (data is Map) {
//         final List<Map<String, dynamic>> loadedMessages = [];
//
//         // Iterate over each user's message list.
//         data.forEach((key, value) {
//           if (value is Map && value['messages'] != null) {
//             (value['messages'] as Map).forEach((msgKey, msgValue) {
//               loadedMessages.add(Map<String, dynamic>.from(msgValue));
//             });
//           }
//         });
//
//         setState(() {
//           userMessages = loadedMessages;
//         });
//       } else {
//         print("Data format is not correct.");
//       }
//     } else {
//       print("No messages found.");
//     }
//   }
//
//   /// Sends a reply to a user.
//   void _sendReply(String uid, String reply) {
//     final newMessage = {
//       "sender": "admin",
//       "message": reply,
//       "timestamp": DateTime.now().toIso8601String(),
//     };
//
//     _messagesRef.child(uid).child("messages").push().set(newMessage);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Admin Support Panel")),
//       body: userMessages.isEmpty
//           ? Center(child: Text("No messages available"))
//           : ListView.builder(
//         itemCount: userMessages.length,
//         itemBuilder: (context, index) {
//           final message = userMessages[index];
//
//           return ListTile(
//             title: Text(message['message']),
//             subtitle: Text("Sent by: ${message['sender']}"),
//             trailing: Text(
//               DateTime.parse(message['timestamp']).toLocal().toString(),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
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
