import 'package:finalyeraproject/routes/approutes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/signin/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
     // home: Signin_Page(),
      initialRoute: Approutes.signinscreen,
      onGenerateRoute:Approutes.generateRoute,
    );
  }
}
