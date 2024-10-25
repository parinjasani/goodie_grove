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
    final DatabaseReference historyRef = FirebaseDatabase.instance.ref().child("history");

    // Fetch records filtered by email and sorted by timestamp
    final snapshot = await historyRef
        .orderByChild("email")
        .equalTo(currentUser!.email)
        .once();

    if (snapshot.snapshot.value != null) {
      final data = Map<String, dynamic>.from(snapshot.snapshot.value as Map);

      data.forEach((key, value) {
        redemptionHistory.add(Map<String, dynamic>.from(value));
      });

      // Sort the list in descending order by 'redeemedAt'
      redemptionHistory.sort((a, b) {
        DateTime timeA = DateTime.parse(a['redeemedAt']);
        DateTime timeB = DateTime.parse(b['redeemedAt']);
        return timeB.compareTo(timeA); // Descending order
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
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListTile(
                title: Text(
                  history['productName'],
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Credits Used: ${history['creditsUsed']}',
                  style: TextStyle(color: Colors.black),
                ),
                trailing: Text(
                  history['redeemedAt'] != null
                      ? DateTime.parse(history['redeemedAt'])
                      .toLocal()
                      .toString()
                      : 'Unknown time',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//
//
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
//           return Card(
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: ListTile(
//                 title: Text(history['productName'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
//                 subtitle: Text('Credits Used: ${history['creditsUsed']}',style: TextStyle(color: Colors.black)),
//                 trailing: Text(
//                   history['redeemedAt'] != null
//                       ? DateTime.parse(history['redeemedAt']).toLocal().toString()
//                       : 'Unknown time',
//                 style: TextStyle(color: Colors.black)),
//               ),
//             ),
//           );
//
//         },
//       ),
//     );
//   }
// }
