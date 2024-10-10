import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyeraproject/models/Employee.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseSingleton{

  static final FirebaseSingleton _instance = FirebaseSingleton._internal();

  factory FirebaseSingleton(){
    return _instance;
  }



  FirebaseSingleton._internal();

  final FirebaseAuth mAuth = FirebaseAuth.instance;

  final DatabaseReference _mRef = FirebaseDatabase.instance.ref();

  Future<dynamic> login(String email,String password) async {
  UserCredential credential =  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  return credential;
  }
  static Future<DocumentSnapshot> adminsignin(id) async{
    var result= FirebaseFirestore.instance.collection("admin").doc(id).get();
    return result;
  }

  Future<void> logout() async {
    return await mAuth.signOut();
  }

   Future<dynamic> forgetmethod(String email) async {
    var forgetcredential  = await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    return forgetcredential;
  }
  /* get the all userdata for adminpanel*/
  //  Stream<List<Employee>> getUserlist() {
  //
  //   return _mRef.child("employee").onValue.map((event) {
  //     final map = event.snapshot.value as Map<String, dynamic>;
  //     if (map == null) {
  //       return [];
  //     }
  //     return map.values.map((e) {
  //       Map<String, dynamic> value = e;
  //       return Employee.fromMap(value);
  //     }).toList();
  //   });
  // }

  Stream<List<Employee>> getUserlist() {
    return _mRef.child("employee").onValue.map((event) {
      final data = event.snapshot.value;

      if (data == null) {
        return <Employee>[]; // Return an empty list if there's no data
      }

      if (data is Map<dynamic, dynamic>) {
        // If the data is a Map
        return data.values.map((e) {
          if (e is Map<dynamic, dynamic>) {
            return Employee.fromMap(Map<String, dynamic>.from(e));
          }
          return null; // Handle unexpected data types
        }).where((e) => e != null).cast<Employee>().toList();
      } else if (data is List<dynamic>) {
        // If the data is a List
        return data
            .where((e) => e != null) // Filter out null values
            .map((e) {
          if (e is Map<dynamic, dynamic>) {
            return Employee.fromMap(Map<String, dynamic>.from(e));
          }
          return null; // Handle unexpected data types
        })
            .where((e) => e != null) // Filter out null values
            .cast<Employee>() // Cast the resulting iterable to Employee
            .toList();
      } else {
        return <Employee>[]; // Return an empty list for unexpected data types
      }
    });
  }





  Future<void> updateEmployeeCreditByEmail(String email, int newCredit) async {
    // Query to get the employee list
    final snapshot = await _mRef.child("employee").once();

    // Check if the snapshot has data
    if (snapshot.snapshot.value != null) {
      final data = snapshot.snapshot.value;

      // Check if the data is a List
      if (data is List<dynamic>) {
        for (int i = 0; i < data.length; i++) {
          if (data[i] != null && data[i]["email"] == email) {
            // Update the credit field of the specific employee
            await _mRef.child("employee/$i").update({
              "credit": newCredit,
            });

            print("Credit updated successfully.");
            return; // Exit the function after updating
          }
        }
        print("Employee with email $email not found.");
      } else {
        print("Data is not in the expected List format.");
      }
    } else {
      print("No employee data found.");
    }
  }

  Future<String?> registerUser({
    required String email,
    required String password,
    required String username,
    String? profilePicUrl, // Nullable profilePicUrl
    required int credit,
  }) async {
    try {
      // Check if the email already exists in Realtime Database
      DatabaseEvent event = await _mRef
          .child('employee')
          .orderByChild('email')
          .equalTo(email)
          .once();

      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        // Email already exists
        return 'User with this email already exists';
      }

      // Create a new user in Firebase Authentication
      UserCredential userCredential = await mAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Prepare user data
      Map<String, dynamic> userData = {
        'email': email,
        'username': username,
        'credit': credit,
      };

      // If profilePicUrl is provided, add it to the user data
      if (profilePicUrl != null && profilePicUrl.isNotEmpty) {
        userData['profilePicUrl'] = profilePicUrl;
      } else {
        userData['profilePicUrl'] = "${userData['email']}example.com";  // Set a blank value if not provided
      }

      // Add user data to Realtime Database
      await _mRef.child('employee').child(userCredential.user!.uid).set(userData);

      // Successfully registered
      return null; // Return null to indicate success
    } catch (e) {
      // Handle errors such as weak password, email already in use, etc.
      print("Error: $e");
      return 'Failed to register user';
    }
  }





}
