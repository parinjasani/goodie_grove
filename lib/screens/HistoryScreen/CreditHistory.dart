import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> redemptionHistory = [];
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    final DatabaseReference historyRef =
    FirebaseDatabase.instance.ref().child("history");

    final snapshot = await historyRef
        .orderByChild("email")
        .equalTo(currentUser!.email)
        .once();

    if (snapshot.snapshot.value != null) {
      // Clear the list to avoid duplicates
      redemptionHistory.clear();

      final data = Map<String, dynamic>.from(snapshot.snapshot.value as Map);

      // Extract and sort by 'redeemedAt' timestamp (most recent first)
      data.forEach((key, value) {
        redemptionHistory.add(Map<String, dynamic>.from(value));
      });

      redemptionHistory.sort((a, b) {
        return DateTime.parse(b['redeemedAt'])
            .compareTo(DateTime.parse(a['redeemedAt']));
      });

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Redemption History"),
      ),
      body: redemptionHistory.isEmpty
          ? Center(child: Text("No history available"))
          : ListView.builder(
        itemCount: redemptionHistory.length,
        itemBuilder: (context, index) {
          final history = redemptionHistory[index];

          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                history['productImageUrl'] ??
                    'https://via.placeholder.com/50', // Default placeholder
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              history['productName'] ?? 'Unknown Product',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Credits Used: ${history['creditsUsed']}'),
            trailing: Text(
              history['redeemedAt'] != null
                  ? DateTime.parse(history['redeemedAt'])
                  .toLocal()
                  .toString()
                  : 'Unknown time',
            ),
          );
        },
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class HistoryScreen extends StatefulWidget {
//   @override
//   _HistoryScreenState createState() => _HistoryScreenState();
// }
//
// class _HistoryScreenState extends State<HistoryScreen> {
//   List<Map<String, dynamic>> redemptionHistory = [];
//   User? currentUser;
//
//   @override
//   void initState() {
//     super.initState();
//     currentUser = FirebaseAuth.instance.currentUser;
//     fetchHistory();
//   }
//
//   Future<void> fetchHistory() async {
//     final DatabaseReference historyRef = FirebaseDatabase.instance.ref().child("history");
//     final snapshot = await historyRef.orderByChild("email").equalTo(currentUser!.email).once();
//
//     if (snapshot.snapshot.value != null) {
//       final data = Map<String, dynamic>.from(snapshot.snapshot.value as Map);
//       data.forEach((key, value) {
//         redemptionHistory.add(Map<String, dynamic>.from(value));
//       });
//       setState(() {});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Redemption History"),
//
//       ),
//       body: redemptionHistory.isEmpty
//           ? Center(child: Text("No history available"))
//           : ListView.builder(
//         itemCount: redemptionHistory.length,
//         itemBuilder: (context, index) {
//           final history = redemptionHistory[index];
//           return ListTile(
//             title: Text(history['productName']),
//             subtitle: Text('Credits Used: ${history['creditsUsed']}'),
//             trailing: Text(
//               history['redeemedAt'] != null
//                   ? DateTime.parse(history['redeemedAt']).toLocal().toString()
//                   : 'Unknown time',
//             ),
//           );
//
//         },
//       ),
//     );
//   }
// }
