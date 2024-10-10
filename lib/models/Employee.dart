import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Employee{

  int? credit;
  String? username;
  String? profilepicurl;
  String? email;


  Employee({this.credit, this.username, this.profilepicurl, this.email});

  Map<String, dynamic> toMap() {
    return {
      'credit': this.credit,
      'username': this.username,
      'profilepicurl': this.profilepicurl,
      'email': this.email,
    };
  }

  factory Employee.fromMap(Map<dynamic, dynamic> map) {
    return Employee(
      credit: map['credit'] as int,
      username: map['username'] as String,
      profilepicurl: map['profilepicurl'] as String,
      email: map['email'] as String,
    );
  }
  static Future<Employee?> getEmployee(String uid) async {
    DocumentSnapshot snapshot =
    await FirebaseFirestore.instance.collection('employees').doc(uid).get();
    if (snapshot.exists) {
      return Employee.fromMap(snapshot.data() as Map<String, dynamic>);
    }
    return null;
  }

}