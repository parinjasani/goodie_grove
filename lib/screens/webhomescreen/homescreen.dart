import 'package:flutter/material.dart';
import 'components/body.dart';
import 'components/homescreen_drawer.dart';
class HomeScreen extends StatelessWidget {
  // User ? user;
  // HomeScreen(this.user);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Body(),
      drawer: HomeScreenDrawer(),
    );
  }

}
