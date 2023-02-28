import 'package:flutter/material.dart';

var kBackgroundColor = Colors.white;

void gotoScreen(BuildContext context, dynamic route) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => route));
}

void clearAndGoto(BuildContext context, dynamic route) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => route),
      (Route<dynamic> route) => false);
}

void gotoAndRemove(BuildContext context, dynamic route) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => route),
      (Route<dynamic> route) => false);
}
