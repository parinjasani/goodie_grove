import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finalyeraproject/models/Employee.dart';
import '../../Firebase/firebase_singleton.dart';
import '../../routes/approutes.dart';
import '../HistoryScreen/CreditHistory.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseSingleton _service = FirebaseSingleton();
  User? currentUser;
  Employee? employee;
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    fetchEmployeeDetails();
  }

  Future<void> fetchEmployeeDetails() async {
    try {
      employee = await _service.getOneEmployeeByUid(currentUser!.uid!);
      print(currentUser!.uid!);// Fetch employee details
    } catch (e) {
      print("Error fetching employee details: $e");
    }
    if (employee == null) {
      print("Employee not found for email: ${currentUser!.email!}");
    }
    setState(() {
      isLoading = false; // Fetching done, stop loading
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        // backgroundColor: Colors.teal,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator while fetching data
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.black,

                backgroundImage: (employee?.profilepicurl != null && employee!.profilepicurl!.isNotEmpty)
                    ? NetworkImage(employee!.profilepicurl!)
                    : null,
                child: (employee?.profilepicurl == null || employee!.profilepicurl!.isEmpty)
                    ? Text(
                  currentUser?.email![0].toUpperCase() ?? 'U', // Show initial letter or 'U'
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,

                  ),
                )
                    : null,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                employee?.username ?? currentUser!.email!,
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                employee?.email ?? currentUser!.email!,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text("Credits"),
              trailing: Text(
                employee?.credit?.toString() ?? '0',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            ListTile(
              onTap: () {
                //Navigator.pushNamed(context, Approutes.historyscreen); // Route to History
                Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryScreen(),));
              },
              title: Text("History"),
              leading: Icon(Icons.book),
            ),
            Divider(color: Colors.grey),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, Approutes.settingscreen); // Route to Settings
              },
              title: Text("Settings"),
              leading: Icon(Icons.settings),
            ),


            Divider(color: Colors.grey),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, Approutes.helpsupportscreen); // Route to Help & Support
              },
              title: Text("Help & Support"),
              leading: Icon(Icons.help_outline_rounded),
            ),
            Divider(color: Colors.grey),
            ListTile(
              title: Text("Logout"),
              leading: Icon(Icons.logout),
              onTap: () {
                _service.logout().then((value) => Navigator.restorablePushNamedAndRemoveUntil(
                    context, Approutes.signinscreen, (route) => false));
              },
            ),
          ],
        ),
      ),
    );
  }
}