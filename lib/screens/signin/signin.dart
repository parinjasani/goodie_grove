import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Firebase/firebase_singleton.dart';
import '../../routes/approutes.dart';


class Signin_Page extends StatelessWidget {
   Signin_Page({Key? key}) : super(key: key);


  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  FirebaseSingleton service = FirebaseSingleton();
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();

  }
  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey[300],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Hello Again!',
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
                      color: Colors.grey[200]),
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Email",hintStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
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
                          hintStyle: TextStyle(color: Colors.black)
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
                    if (credential is UserCredential){
                      if(credential.user != null){
                        print("Login made successfully");

                        Navigator.pushNamedAndRemoveUntil(context, Approutes.homescreen, (route) => false);

                      }
                    }
                    else if(credential is String)
                    {
                      //exception return failed
                      print("exception occur");
                    }
                    else{
                      print("object is null");
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                    child: const Text("Sign in", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
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
                  Text('Forget password?', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Approutes.forgetpasswordscreen);
                    },
                      child: Text('   Get Password', style: TextStyle(fontSize: 18,color: Colors.black54,fontWeight: FontWeight.bold),)),
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


