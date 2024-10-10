import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../routes/approutes.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 6), () {
      //NAvigate to onboradiing
      // FirebaseAuth.instance.authStateChanges().listen((User? user) {
      //   if (user != null) {
      //     print('User is signed in ');
        // Navigator.pushReplacementNamed(context, Approutes.homescreen);
      //   } else {
      //          Navigator.pushReplacementNamed(context, Approutes.signinscreen);
      //   }
      // });//this logic seperated in the landing page

      Navigator.pushReplacementNamed(context, Approutes.landingscreen);

    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: Backgroungradiant,
          ),
        ),
        Center(
          child: Image.asset(
           // "assets/images/shop-logo.png",
            "assets/images/splash.png",
            height: 600,
            width: 300,
          ),
        )
      ],
    );
  }
}
