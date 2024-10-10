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


}