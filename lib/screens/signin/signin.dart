import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Firebase/firebase_singleton.dart';
import '../../routes/approutes.dart';

class Signin_Page extends StatelessWidget {
  Signin_Page({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  FirebaseSingleton service = FirebaseSingleton();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Hello Again!',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 36),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Welcome back, you've been missed!",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Form(
                    key: _formKey, // Wrap inputs inside Form
                    child: Column(
                      children: [
                        _buildEmailField(),
                        const SizedBox(height: 15),
                        _buildPasswordField(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildSignInButton(context),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Forget password?',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, Approutes.forgetpasswordscreen);
                      },
                      child: const Text(
                        '   Get Password',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build Email TextFormField with validation
  Widget _buildEmailField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Email",
            hintStyle: TextStyle(color: Colors.black),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required';
            } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
              return 'Enter a valid email';
            }
            return null;
          },
        ),
      ),
    );
  }

  // Build Password TextFormField with validation
  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.black),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required';
            } else if (value.length < 6) {
              return 'Password must be at least 6 characters long';
            }
            return null;
          },
        ),
      ),
    );
  }

  // Build Sign-In Button with login logic and error handling
  Widget _buildSignInButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            await _login(context);
          }
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
          child: const Text(
            "Sign in",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // Login function with error handling for invalid credentials
  Future<void> _login(BuildContext context) async {
    try {
      UserCredential credential = await service.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (credential.user != null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Approutes.homescreen,
              (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password. Please try again.';
      } else {
        errorMessage = 'Login failed. Please try again later.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred.')),
      );
    }
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../../Firebase/firebase_singleton.dart';
// import '../../routes/approutes.dart';
//
//
// class Signin_Page extends StatelessWidget {
//    Signin_Page({Key? key}) : super(key: key);
//
//
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   FirebaseSingleton service = FirebaseSingleton();
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _emailController.dispose();
//     _passwordController.dispose();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//
//
//     return SafeArea(
//       child: Scaffold(
//         // backgroundColor: Colors.grey[300],
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Hello Again!',
//                 style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 36),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const Text(
//                 "Welcome back, you've been missed!",
//                 style: TextStyle(color: Colors.black,fontSize: 20),
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 18),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: Colors.grey[200]),
//                   child:  Padding(
//                     padding: const EdgeInsets.only(left: 20),
//                     child: TextField(
//                       controller: _emailController,
//                       decoration: const InputDecoration(
//                           border: InputBorder.none, hintText: "Email",hintStyle: TextStyle(color: Colors.black)),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 18),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: Colors.grey[200]),
//                   child:  Padding(
//                     padding: const EdgeInsets.only(left: 20),
//                     child: TextField(
//                       controller: _passwordController,
//                       obscureText: true,
//                       decoration: const InputDecoration(
//                         border: InputBorder.none,
//                         hintText: "Password",
//                           hintStyle: TextStyle(color: Colors.black)
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20,),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: GestureDetector(
//                   onTap: () async {
//                     UserCredential credential =  await service.login(_emailController.text.toString(), _passwordController.text.toString());
//                     if (credential is UserCredential){
//                       if(credential.user != null){
//                         print("Login made successfully");
//
//                         Navigator.pushNamedAndRemoveUntil(context, Approutes.homescreen, (route) => false);
//
//                       }
//                     }
//                     else if(credential is String)
//                     {
//                       //exception return failed
//                       print("exception occur");
//                     }
//                     else{
//                       print("object is null");
//                     }
//                   },
//                   child: Container(
//                     padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
//                     child: const Text("Sign in", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
//                     decoration: BoxDecoration(
//                       color: Colors.indigo,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 25,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Forget password?', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushNamed(context, Approutes.forgetpasswordscreen);
//                     },
//                       child: Text('   Get Password', style: TextStyle(fontSize: 18,color: Colors.black54,fontWeight: FontWeight.bold),)),
//                 ],
//               )
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Future<void> logincheck(String emailp, String passwordp) async {
//   //   UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//   //       email: emailp,
//   //       password: passwordp
//   //   );
//   //   if(credential.user != null){
//   //     print("login successfully: ${credential.user!.uid}" );
//   //   } else{
//   //     print("Invalid email and password");
//   //   }
//   // }
// }
//
//
