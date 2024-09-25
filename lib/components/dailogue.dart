import 'package:flutter/material.dart';
class Dailogue extends StatelessWidget {
  final String? title;
  const Dailogue({Key? key,this.title}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      actions: [
        MaterialButton(
          child: Text("Close"),onPressed: () {
          Navigator.pop(context);
        },)
      ],
    );
  }
}
