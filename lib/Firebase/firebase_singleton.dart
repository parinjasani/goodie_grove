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

      if (data is Map<String, dynamic>) {
        // If the data is a Map
        return data.values.map((e) {
          Map<String, dynamic> value = Map<String, dynamic>.from(e);
          return Employee.fromMap(value);
        }).toList();
      } else if (data is List<dynamic>) {
        // If the data is a List
        return data
            .where((e) => e != null) // Filter out null values if any
            .map((e) {
          Map<String, dynamic> value = Map<String, dynamic>.from(e);
          return Employee.fromMap(value);
        })
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



  Future<Employee?> getOneEmployeeByUid(String uid) async {
    // Query to get the employee data
    final snapshot = await _mRef.child("employee").once();

    // Check if the snapshot has data
    if (snapshot.snapshot.value != null) {
      final data = snapshot.snapshot.value;

      // Check if data is a Map
      if (data is Map<dynamic, dynamic>) {
        // Check if the UID exists in the data
        if (data.containsKey(uid)) {
          // Get the employee data for the specified UID
          final employeeData = data[uid];

          // Ensure employeeData is a Map and convert it safely
          if (employeeData is Map<Object?, Object?>) {
            return Employee.fromMap(employeeData.cast<String, dynamic>());
          }
        } else {
          print("Employee with UID $uid not found."); // Log if UID is not found
        }
      } else {
        print("Data is not in the expected Map format."); // Log if data is not a map
      }
    } else {
      print("No employee data found."); // Log if no data is found
    }

    return null; // Return null if no matching employee is found
  }





  Future<void> updateEmployeeCredits(String email, int newCredits) async {
    final snapshot = await _mRef.child("employee").once();
    if (snapshot.snapshot.value != null) {
      final data = snapshot.snapshot.value as List;
      for (int i = 0; i < data.length; i++) {
        if (data[i]["email"] == email) {
          await _mRef.child("employee/$i/credit").set(newCredits);
          return;
        }
      }
    }
  }

  // Add redemption history
  Future<void> addRedemptionHistory(String email, String productName, int creditsUsed) async {
    final historyRef = _mRef.child("history").push();
    await historyRef.set({
      'email': email,
      'productName': productName,
      'creditsUsed': creditsUsed,
      'redeemedAt': DateTime.now().toIso8601String(),
    });
  }
}


