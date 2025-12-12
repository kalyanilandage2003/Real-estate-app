import 'package:flutter/material.dart';

const Color blueGrey = Colors.blueGrey;
const Color blue = Colors.blue;
const Color blue200 = Color.fromRGBO(144, 202, 249, 1);
const Color blue400 = Color.fromRGBO(66, 165, 245, 1);
const Color black = Colors.black;
const Color black12 = Colors.black12;
const Color black45 = Colors.black45;
const Color black87 = Colors.black87;
const Color white = Colors.white;
const Color whiteShadow = Color.fromRGBO(255, 255, 255, 0.1);
const Color deepPurple = Colors.deepPurple;
const Color buttonColor = Color.fromRGBO(31, 121, 111, 0.5);
const Color enabledBorder = Color.fromRGBO(144, 154, 158, 1);
const Color teal = Colors.teal;
const Color teal200 = Color.fromRGBO(128, 203, 196, 1);
const Color teal400 = Color.fromRGBO(77, 182, 172, 1);
const Color teal800 = Color.fromRGBO(0, 105, 92, 1);
const Color lightGrey = Color.fromRGBO(242, 242, 242, 1);
const Color grey600 = Color.fromRGBO(117, 117, 117, 1);
const Color grey700 = Color.fromRGBO(97, 97, 97, 1);
const Color grey800 = Color.fromRGBO(66, 66, 66, 1);
const Color grey900 = Color.fromRGBO(33, 33, 33, 1);
const Color grey = Colors.grey;
const Color homeTextColor = Color.fromRGBO(51, 202, 184, 1);
const Color red = Colors.red;
const Color green = Colors.green;
const Color green200 = Color.fromRGBO(165, 214, 167, 1);
const Color green400 = Color.fromRGBO(102, 187, 106, 1);
const Color orange = Colors.orange;
const Color orange200 = Color.fromRGBO(255, 204, 128, 1);
const Color orange400 = Color.fromRGBO(255, 171, 64, 1);
const Color purple = Colors.purple;
const Color purple200 = Color.fromRGBO(179, 136, 255, 1);
const Color purple400 = Color.fromRGBO(124, 77, 255, 1);
const Color green700 = Color.fromRGBO(56, 142, 60, 1);
const Color green100 = Color.fromRGBO(200, 230, 201, 1);
const Color orange100 = Color.fromRGBO(255, 224, 178, 1);
const Color orange700 = Color.fromRGBO(245, 124, 0, 1);
const Color white70 = Colors.white70;
const Color white24 = Colors.white24;
const Color redAccent = Colors.redAccent;
const Color amber = Colors.amber;
const Color indicatorColor = Color.fromARGB(150, 203, 156, 27);
const Color transparent = Colors.transparent;
const Color black26 = Colors.black26;
const Color black54 = Colors.black54;
const Color blueAccent = Colors.blueAccent;
const Color pink400 = Color.fromRGBO(236, 64, 122, 1);
const Color pink200 = Color.fromRGBO(244, 143, 177, 1);

void goToPush(BuildContext context, Widget nextScreen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => nextScreen));
}

void goToPushReplacement(BuildContext context, Widget nextScreen) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => nextScreen),
  );
}

void gotoBack(BuildContext context) {
  Navigator.of(context).pop();
}
