import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Firebase/firebase_singleton.dart';
import '../forgetpassword/forget_password_page.dart';

class Signin_Page extends StatelessWidget {
  const Signin_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    FirebaseSingleton service = FirebaseSingleton();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Hello Again!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Welcome back, you've been missed!",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200]),
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Email"),
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
                      color: Colors.grey[200]),
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    UserCredential credential =  await service.login(_emailController.text.toString(), _passwordController.text.toString());
                   if(credential.user != null){
                     print("Login made successfully");
                   } else{
                     print("Invaild login");
                   }
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: const Text("Sign In", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Forget password?', style: TextStyle(fontWeight: FontWeight.bold),),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Forget_Password_Page(),));
                    },
                      child: Text('   Get Password', style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  // Future<void> logincheck(String emailp, String passwordp) async {
  //   UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: emailp,
  //       password: passwordp
  //   );
  //   if(credential.user != null){
  //     print("login successfully: ${credential.user!.uid}" );
  //   } else{
  //     print("Invalid email and password");
  //   }
  // }
}


