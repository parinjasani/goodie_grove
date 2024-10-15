import 'package:finalyeraproject/routes/approutes.dart';
import 'package:finalyeraproject/screens/adminprofile/AdminPROFILE.dart';
import 'package:finalyeraproject/screens/creditmanagement/creditmanagement.dart';
import 'package:finalyeraproject/screens/feedback/feedback.dart';
import 'package:finalyeraproject/screens/giftmanagement/giftmanagement.dart';
import 'package:finalyeraproject/screens/giftmanagement/updategodiess.dart';
import 'package:finalyeraproject/screens/notification/notification.dart';
import 'package:finalyeraproject/screens/usermanagement/usermanagement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class WebMainScreen extends StatefulWidget {
  @override
  State<WebMainScreen> createState() => _WebMainScreenState();
}

class _WebMainScreenState extends State<WebMainScreen> {
  Widget selectedScreen=AdminProfile();
  choosescreen(item){
    switch(item){
      case Approutes.adminprofilescreen:
        setState(() {
          selectedScreen=const AdminProfile();
        });
        break;
      case Approutes.usermanagementscreen:
        setState(() {
          selectedScreen=const UsermanagementScreen();
        });
        break;
      case Approutes.creditmanagementscreen:
        setState(() {
          selectedScreen= CreditManagement();
        });
        break;
      case Approutes.giftmanagementscreen:
        setState(() {
          selectedScreen= GiftmanagementScreen();
        });
        break;
      case Approutes.feedbackscreen:
        setState(() {
          selectedScreen=FeedbackScreen();
        });
        break;
      case Approutes.notificationscreen:
        setState(() {
          selectedScreen= NotificationScreen();
        });
        break;
      case Approutes.updategoodiesscreen:
        setState(() {
          selectedScreen=const UpadateGoodies();
        });
        break;
      default:
        selectedScreen=Center(
          child: Text("Locha labacha"),
        );
    }
  }
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "ADMIN",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          ),
        ),
        sideBar:  SideBar(

         backgroundColor: Colors.black,
          textStyle: TextStyle(color: Colors.white),
          onSelected: (item) {
            choosescreen(item.route);
          },
          borderColor: Colors.white,
          items: const [
            AdminMenuItem(title: "My Profile", icon: Icons.person,route: Approutes.adminprofilescreen),
            AdminMenuItem(
                title: "credit Management",
                icon: Icons.supervised_user_circle_outlined,route: Approutes.usermanagementscreen),
            AdminMenuItem(title: "user Management", icon: Icons.credit_card,route: Approutes.creditmanagementscreen),
            AdminMenuItem(title: "Add Goodies", icon: Icons.card_giftcard,route: Approutes.giftmanagementscreen),
            AdminMenuItem(title: "Update Goodies", icon: Icons.card_giftcard,route: Approutes.updategoodiesscreen),
            AdminMenuItem(title: "Notification", icon: Icons.notifications,route: Approutes.notificationscreen),
            AdminMenuItem(title: "Feedback", icon: Icons.feedback,route: Approutes.feedbackscreen),
            AdminMenuItem(title: "Setting", icon: Icons.settings),
            AdminMenuItem(title: "Logout", icon: Icons.logout),
          ],
          selectedRoute: Approutes.webmainscreen,
        ),
        body: selectedScreen);
  }
}
