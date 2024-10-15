import 'package:flutter/material.dart';

ThemeData apptheme() {
  return ThemeData(
      //scaffoldBackgroundColor: Colors.white,
      scaffoldBackgroundColor: Color(0xFF2E3A3F),
      //scaffoldBackgroundColor: Colors.black,
       primarySwatch: Colors.indigo,
      // primaryColor: Color(0xff54A97A),
      // // Primary Greenish color
      // hintColor: Color(0xFF54A97A),
      // Accent color for highlights
      elevatedButtonTheme: elevatedButtonTheme(),
      textButtonTheme: textbuttontheme(),
      inputDecorationTheme: inputdecorationtheme(),
      appBarTheme: appbartheme(),
      iconTheme: IconsTheme(),
      dividerTheme: dividertheme(),
      listTileTheme: listtilletheme(),
      textTheme: textTheme(),
  cardTheme: cardtheme());
}

cardtheme() {
  return CardTheme(
    color: Colors.white
  );
}

listtilletheme() {
  return ListTileThemeData(
     // Background color of ListTile
    selectedTileColor: Colors.white, // Color when ListTile is selected
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // Rounded corners
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding inside ListTile

    textColor: Colors.white, // Text Color for ListTile
    iconColor: Colors.white, // Icon Color for ListTile
  );
}

dividertheme() {
  return DividerThemeData(
    color: Color(0xFFBCCDC2), // Soft greenish-grey divider color
    thickness: 1,
  );
}

IconsTheme() {
  return IconThemeData(
    color: Color(0xFF4E6E60), // Muted green-grey icons across the app
  );
}

elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    // style: ButtonStyle(
    //   backgroundColor: MaterialStateProperty.resolveWith<Color>(
    //     (Set<MaterialState> states) {
    //       if (states.contains(MaterialState.pressed)) {
    //         return Color(0xFF388E7A); // Darken button on press
    //       } else if (states.contains(MaterialState.hovered)) {
    //         return Color(0xFF4CAF7E); // Lighter green on hover
    //       }
    //       return Color(0xFF54A97A); // Default button color
    //     },
    //   ),
    //   foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    //   // White text on buttons
    //   padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
    //     EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    //   ),
    //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //     RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(8),
    //     ),
    //   ),
    // ),
    style: ButtonStyle(
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(horizontal: 30),
      ),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      backgroundColor: MaterialStateProperty.all(Color(0xff4CAF7E )),
    ),
  );
}

textTheme() {
  return TextTheme(
    // bodyLarge: TextStyle(
    //   color: Colors.white,//Color(0xFF4E6E60), // General text color (muted green-grey)
    //   fontSize: 16,
    // ),
    // bodyMedium: TextStyle(
    //   color: Colors.white70,//Color(0xFF4E6E60), // Small text
    //   fontSize: 14,
    // ),
    // titleLarge: TextStyle(
    //   color: Colors.white, // For headings in AppBars
    //   fontSize: 20,
    //   fontWeight: FontWeight.bold,
    // ),
     bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
  );
}

appbartheme() {
  return AppBarTheme(

      color: Colors.black38.withOpacity(0.2),//Color(0xFF388E7A), // Darker greenish-teal for AppBar
      iconTheme: IconThemeData(color: Colors.white), // AppBar icons in white
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      )
      // color: Color(0xFF388E7A), // AppBar background color
      // iconTheme: IconThemeData(color: Colors.white), // AppBar icon color
      // titleTextStyle: TextStyle(
      //   color: Colors.white,
      //   fontSize: 20,
      //   fontWeight: FontWeight.bold,

      // backgroundColor: Colors.white,
      // centerTitle: true,
      // foregroundColor: Colors.black,
      // iconTheme: IconThemeData(color: Colors.black),
      );
}

inputdecorationtheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),

    gapPadding: 10,
    borderSide: BorderSide(color: Colors.transparent,width: 1.5),
  );
  return InputDecorationTheme(
    //filled: true,
    fillColor: Colors.white,
    hintStyle: TextStyle(color: Colors.white),
      border: outlineInputBorder);
}

textbuttontheme() {
  return TextButtonThemeData(
      style: ButtonStyle(
    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 16)),
    textStyle: MaterialStateProperty.all(
        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    foregroundColor: MaterialStateProperty.all(Colors.indigo),
    backgroundColor: MaterialStateProperty.all(Colors.white),
  ));
}
