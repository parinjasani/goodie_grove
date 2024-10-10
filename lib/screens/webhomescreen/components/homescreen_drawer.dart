import 'package:finalyeraproject/routes/approutes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Firebase/firebase_singleton.dart';



class HomeScreenDrawer extends StatelessWidget {

  FirebaseSingleton _service = FirebaseSingleton();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          builduseraccountHeader(),
          ListTile(
            title: Text("My Profile"),
            leading: Icon(Icons.add_box_outlined),
            //navigate to categorylist screen
            onTap: () {
             Navigator.pushNamed(context, Approutes.profilescreen);
            },
          ),
          ListTile(
            onTap: () {
             // Navigator.pushNamed(context, Approutes.);
            },
            title: Text("Credit & History"),
            leading: Icon(Icons.add_box_outlined),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, Approutes.settingscreen);
            },
            title: Text("Settings"),
            leading: Icon(Icons.add_box_outlined),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, Approutes.helpsupportscreen);
            },
            title: Text("Help & Support"),
            leading: Icon(Icons.add_box_outlined),
          ),
          Divider(
            height: 30,
            indent: 40,
            color: Colors.grey,
          ),
          ListTile(
            title: Text("Logout"),
            leading: Icon(Icons.logout),
            onTap: () {
              _service.logout().then((value) => Navigator.restorablePushNamedAndRemoveUntil(context, Approutes.signinscreen, (route) => false));
            },
          ),
        ],
      ),
    );
  }

  builduseraccountHeader() {
    return UserAccountsDrawerHeader(
      accountName: Text(
        "Parin",
        style: TextStyle(color: Colors.white),
      ),
      accountEmail: Text(
        "${FirebaseAuth.instance.currentUser!.email}",
        style: TextStyle(color: Colors.white),
      ),
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: Colors.blueAccent
      ),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: Image.asset(
          "assets/images/userlogo.png", height: 60, width: 60,),
      ),
    );
  }
}
