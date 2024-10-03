import 'package:finalyeraproject/routes/approutes.dart';
import 'package:finalyeraproject/screens/landingscreen/landingscreen.dart';
import 'package:finalyeraproject/screens/layout/LayoutScreen.dart';
import 'package:finalyeraproject/theme.dart';
import 'package:finalyeraproject/web_side/web_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import 'screens/signin/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: FirebaseOptions(
       databaseURL: "https://goodie-grove-f75a5-default-rtdb.firebaseio.com",
        apiKey: "AIzaSyC8rTYtLK9b1YsakTJeLHsKHBu6Vztg58M",
        authDomain: "goodie-grove-f75a5.firebaseapp.com",
        projectId: "goodie-grove-f75a5",
        storageBucket: "goodie-grove-f75a5.appspot.com",
        messagingSenderId: "158237292727",
        appId: "1:158237292727:web:1c3e985ba4e2781ef27532",
        measurementId: "G-HBBL1X8GKF"
        ));
  }
  else{
    await Firebase.initializeApp();
  }

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        theme: apptheme(),
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: LayoutScreen(),
        //initialRoute: Approutes.splashscreen,
        onGenerateRoute:Approutes.generateRoute,
      ),
    );
  }
}
