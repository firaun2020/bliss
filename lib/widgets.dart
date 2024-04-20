import 'package:flutter/material.dart';

Widget headingText(headingColor, decorationColor, text) {
  return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: headingColor,
          letterSpacing: 1.5,
          decorationThickness: 1.0,
          decoration: TextDecoration.combine(
              [TextDecoration.overline, TextDecoration.underline]),
          decorationColor: decorationColor,
          fontWeight: FontWeight.bold,
        ),
      ));
}
