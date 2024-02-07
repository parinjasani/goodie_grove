
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Forget_Password_Page extends StatelessWidget {
  const Forget_Password_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _forgetpassword = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "Enter Your Email and we will send you a password reset link",
                style: TextStyle(fontSize: 20),
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200]),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  controller: _forgetpassword,
                  decoration: InputDecoration(
                      hintText: "Enter Email", border: InputBorder.none),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      String forgetpassword = _forgetpassword.text.toString();
                       forgetmethod(context, forgetpassword);
                    },
                    child: const Text(
                      "Reset Password",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> forgetmethod(BuildContext context,String email) async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showDialog(context: context, builder: (context) {
        return const AlertDialog(
          content: Text("Reset password link sent!!!"),
        );
      },);
    } on FirebaseAuthException catch(e){
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      },);
    }

  }
}
