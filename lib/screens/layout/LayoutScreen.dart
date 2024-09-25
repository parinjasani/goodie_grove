import 'package:finalyeraproject/screens/splashscreen/splashscreen.dart';
import 'package:finalyeraproject/web_side/web_login.dart';
import 'package:flutter/material.dart';
class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.minWidth>600)
        {
          return  WebLoginScreen();
        }
      else{
        return SplashScreen();
      }
    },);
  }
}
