import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Poppins",
    textTheme: textTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

TextTheme textTheme() {
  return TextTheme(
    headline1: TextStyle(color: primaryColor),
    headline2: TextStyle(color: Colors.black),
    subtitle2: TextStyle(color: Colors.black),
    bodyText1: TextStyle(color: Colors.black),
    caption: TextStyle(color: Colors.black),
  );
}
