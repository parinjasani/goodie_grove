import 'package:flutter/material.dart';

class AdminProfile extends StatelessWidget {
  // Sample admin data - Replace with real data from Firebase
  final String name = "Admin";
  final String email = "admin@gmail.com";
  final String contactNumber = "+91 9857546254";

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Admin Profile'),

      ),
      backgroundColor: Colors.black87, // Background color (Light Sky Blue)
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Row(
                children: [
                  // Circular Avatar with Letter 'A'
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.indigo,
                    child: Text(
                      'A',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 20), // Space between avatar and details
                  // Admin Information
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Name: $name",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("Email: $email"
                          ,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Contact : $contactNumber",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class AdminProfile extends StatefulWidget {
//   @override
//   _AdminProfileState createState() => _AdminProfileState();
// }
//
// class _AdminProfileState extends State<AdminProfile> {
//   final User? admin = FirebaseAuth.instance.currentUser;
//   String? adminName = "Loading...";
//   String? adminEmail = "Loading...";
//   String? adminPhotoURL;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchAdminData();
//   }
//
//   // Fetch the admin's profile data from Firebase Auth
//   void fetchAdminData() {
//     if (admin != null) {
//       setState(() {
//         adminName = admin!.displayName ?? "Admin1";
//         adminEmail = admin!.email ?? "admin1@gmail.com";
//         adminPhotoURL = admin!.photoURL;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(backgroundColor: Colors.black87,
//       appBar: AppBar(
//
//
//         title: const Text("Admin Profile"),
//
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(32.0),
//         child: Row(
//           //mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Profile Picture Section
//             CircleAvatar(
//               radius: 70,
//               backgroundColor: Colors.black,
//               child: adminPhotoURL != null
//                   ? ClipOval(
//                 child: Image.network(
//                   adminPhotoURL!,
//                   width: 140,
//                   height: 140,
//                   fit: BoxFit.cover,
//                 ),
//               )
//                   : Text(
//                 adminName!.substring(0, 1),
//                 style: const TextStyle(
//                   fontSize: 50,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 40),
//
//             // Admin Information Section
//             Column(
//               //crossAxisAlignment: CrossAxisAlignment.start,
//               // mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Name:",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   adminName ?? "Admin Name",
//                   style: const TextStyle(
//                     fontSize: 22,color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 Text(
//                   "Email:",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   adminEmail ?? "No Email Provided",
//                   style: const TextStyle(
//                     fontSize: 18,color:Colors.white
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// class AdminProfile extends StatelessWidget {
//   const AdminProfile({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         "Adminprofile",style: TextStyle(fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
