import 'package:flutter/material.dart';
class Homecard extends StatelessWidget {
  final String? title;
  const Homecard({Key? key,this.title}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: [
              Colors.blueAccent.withOpacity(0.7),
              Colors.redAccent.withOpacity(0.7)]
            )),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            title??"TITLE"
              "$title",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.white)),
        ),
      ),
    );
  }
}
