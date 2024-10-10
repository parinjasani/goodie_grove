import 'package:finalyeraproject/screens/webhomescreen/homescreen.dart';
import 'package:finalyeraproject/screens/signin/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class Landingscreen extends StatelessWidget {
 Future<FirebaseApp> intilize=Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: intilize,builder: (context, snapshot)
      {
        if(snapshot.hasError){
          return Scaffold(
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if(snapshot.connectionState==ConnectionState.done){
          return StreamBuilder(builder: (context, streamsnapshot) {
            if(streamsnapshot.hasError){
              return Scaffold(
                body: Center(
                  child: Text("${streamsnapshot.error}"),
                ),
              );
            }
            if(streamsnapshot.connectionState==ConnectionState.active){
              User? user=streamsnapshot.data;
              if(user==null){
                return Signin_Page();
              }else{
                return HomeScreen();
              }
            }
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("CHECKING AUTHENTICATION",style: TextStyle(fontWeight: FontWeight.bold),),
                    CircularProgressIndicator()
                  ],
                ),
              ),
            ) ;
          },stream: FirebaseAuth.instance.authStateChanges());
        }
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("INITIALIZATION",style: TextStyle(fontWeight: FontWeight.bold),),
                CircularProgressIndicator()
              ],
            ),
          ),
        ) ;
      }, );
  }
}
