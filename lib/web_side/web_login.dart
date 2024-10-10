import 'package:finalyeraproject/components/dailogue.dart';
import 'package:finalyeraproject/web_side/web_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Firebase/firebase_singleton.dart';
import '../routes/approutes.dart';

class WebLoginScreen extends StatefulWidget {
  @override
  State<WebLoginScreen> createState() => _WebLoginScreenState();
}

class _WebLoginScreenState extends State<WebLoginScreen> {
  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool formstateloading = false;

  String? _username, _password;

  submit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() {
        formstateloading = true;
      });
      await FirebaseSingleton.adminsignin(_usernameController.text).then(
        (value) async {
          if (value['username'] == _usernameController.text &&
              value['password'] == _passwordController.text) {
            UserCredential user =
                await FirebaseAuth.instance.signInAnonymously();
            try {
              if (user != null) {
                Navigator.pushReplacementNamed(
                  context, Approutes.webmainscreen,);
                print("login made successfully");
              }
            } catch (e) {
              setState(() {
                formstateloading = false;
              });
              showDialog(
                context: context,
                builder: (context) {
                  return Dailogue(title: e.toString());
                },
              );
            }
          }
        },
      );

      // else{
      //   print("locha hai bhai");
      //
      // }
    }
  }

  FirebaseSingleton service = FirebaseSingleton();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black87,
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Hello ADMIN',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 36),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Welcome back, you've been missed!",
                    style: TextStyle(color: Colors.white,fontSize: 20),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextFormField(
                          onSaved: (newValue) {
                            _username = newValue!;
                          },
                          controller: _usernameController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,hintText: "Username",hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 05,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextFormField(
                          onSaved: (newValue) {
                            _password = newValue!;
                          },
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      color: Colors.indigo,
                      minWidth: 20.h,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      onPressed: () {
                        submit(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    // child: GestureDetector(
                    //   onTap: (){
                    //     if (formKey.currentState!.validate()){
                    //       formKey.currentState!.save();
                    //       if (_emailController==email && _passwordController==password){
                    //         Navigator.push(context, Approutes.webmainscreen as Route<Object?>);
                    //         print("login made successfully");
                    //       }
                    //     }
                    //     else{
                    //       print("kuch locha hai");
                    //     }
                    //   },
                    //   child: Container(
                    //     padding: EdgeInsets.all(15),
                    //     child: const Text("Sign In", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                    //     decoration: BoxDecoration(
                    //       color: Colors.deepPurple,
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //   ),
                    // ),
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  // SizedBox(
                  //   height: 25,
                  // ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'Forget password?',
                  //       style: TextStyle(fontWeight: FontWeight.bold),
                  //     ),
                  //     GestureDetector(
                  //         onTap: () {
                  //           Navigator.pushNamed(
                  //               context, Approutes.forgetpasswordscreen);
                  //         },
                  //         child: Text(
                  //           '   Get Password',
                  //           style: TextStyle(
                  //               color: Colors.blue,
                  //               fontWeight: FontWeight.bold),
                  //         )),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
