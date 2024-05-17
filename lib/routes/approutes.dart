import 'package:flutter/material.dart';

import '../screens/forgetpassword/forget_password_page.dart';
import '../screens/homescreen/homescreen.dart';
import '../screens/signin/signin.dart';

class Approutes {
  // static const splashscreen = '/';
  // static const onboradingscreen = '/onbording';
  static const signinscreen = "/signinscreen";

  //static const signupscreen = "/signupscreen";
  static const forgetpasswordscreen = "/forgetpasswordscreen";
  static const homescreen = "/homescreen";

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;
    switch (settings.name) {
      case signinscreen:
        return MaterialPageRoute(
          builder: (context) => Signin_Page(),
        );
      case forgetpasswordscreen:
        return MaterialPageRoute(builder: (context) => Forget_Password_Page());
      case homescreen:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
    }
  }
}
