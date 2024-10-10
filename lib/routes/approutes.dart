import 'package:finalyeraproject/models/goodies.dart';
import 'package:finalyeraproject/screens/adminprofile/AdminPROFILE.dart';
import 'package:finalyeraproject/screens/creditmanagement/creditmanagement.dart';
import 'package:finalyeraproject/screens/feedback/feedback.dart';
import 'package:finalyeraproject/screens/giftmanagement/giftmanagement.dart';
import 'package:finalyeraproject/screens/giftmanagement/updategodiess.dart';
import 'package:finalyeraproject/screens/giftmanagement/updategoodiescompletescreen.dart';
import 'package:finalyeraproject/screens/landingscreen/landingscreen.dart';
import 'package:finalyeraproject/screens/notification/notification.dart';
import 'package:finalyeraproject/screens/usermanagement/usermanagement.dart';
import 'package:finalyeraproject/web_side/web_login.dart';
import 'package:finalyeraproject/web_side/web_main.dart';
import 'package:flutter/material.dart';

import '../screens/forgetpassword/forget_password_page.dart';
import '../screens/homescreen/homescreen.dart';
import '../screens/signin/signin.dart';
import '../screens/splashscreen/splashscreen.dart';

class Approutes {
  static const splashscreen = '/';
  static const landingscreen='/landingscreen';
  // static const onboradingscreen = '/onbording';
  static const signinscreen = "/signinscreen";

  static const webloginscreen = "/webloginscreen";
  static const webmainscreen = "/webmainscreen";
  static const forgetpasswordscreen = "/forgetpasswordscreen";
  static const homescreen = "/homescreen";

  // webpaes //
  static const updategoodiescompletescreen = "/updategoodiescompletescreen";
  static const updategoodiesscreen = "/updategoodiescreen";
  static const adminprofilescreen = "/adminprofilescreen";
  static const creditmanagementscreen = "/creditmanagement";
  static const giftmanagementscreen = "/giftmanagement";
  static const usermanagementscreen = "/usermanagementscreen";
  static const notificationscreen = "/notification";
  static const feedbackscreen = "/feedbackscreen";


  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;
    switch (settings.name) {
      case splashscreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case signinscreen:
        return MaterialPageRoute(
          builder: (context) => Signin_Page(),
        );
      case webloginscreen:
        return MaterialPageRoute(
          builder: (context) => WebLoginScreen(),
        );
      case webmainscreen:
        return MaterialPageRoute(
          builder: (context) => WebMainScreen(),
        );

      case landingscreen:
        return MaterialPageRoute(
          builder: (context) => Landingscreen(),
        );
      case forgetpasswordscreen:
        return MaterialPageRoute(builder: (context) => Forget_Password_Page());
      case homescreen:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case adminprofilescreen:
        return MaterialPageRoute(
          builder: (context) => AdminProfile(),
        );
      case giftmanagementscreen:
        return MaterialPageRoute(
          builder: (context) => GiftmanagementScreen(),
        );
      case usermanagementscreen:
        return MaterialPageRoute(
          builder: (context) => UsermanagementScreen(),
        );
      case creditmanagementscreen:
        return MaterialPageRoute(
          builder: (context) => CreditManagement(),
        );
      case feedbackscreen:
        return MaterialPageRoute(
          builder: (context) => FeedbackScreen(),
        );
      case notificationscreen:
        return MaterialPageRoute(
          builder: (context) => NotificationScreen(),
        );
      case updategoodiesscreen:
        return MaterialPageRoute(
          builder: (context) => UpadateGoodies(),
        );
      case updategoodiescompletescreen:

        Goodies ? goodies =
        settings.arguments != null ? settings.arguments as Goodies : null;
        return MaterialPageRoute(
          builder: (context) => UpadateGoodiesScreen(goodies: goodies,),
        );
    }
  }
}
