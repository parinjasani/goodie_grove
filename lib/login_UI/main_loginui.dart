import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'signin_page/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Signin_Page(),
    );
  }
}
