import 'package:flutter/material.dart';
// import 'package:moneyfirst/size_config.dart';

// const primaryColor = Colors.black87;
const primaryColor = Color(0xFF1F5673);
// const primaryColor = Color(0xFF4D24A6);
const primaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF271BB4), Color(0xFFC31F46)],
);
const secondaryColor = Color(0xFF271BB4);
const tertiaryColor = Color(0xFFC31F46);
const googleColor = Color(0xFF4285F4);
const facebookColor = Color(0xFF4267B2);
const appleColor = Color(0xFF000000);

const animationDuration = Duration(milliseconds: 500);

// final headingStyle = TextStyle(
//   fontSize: getProportionateScreenWidth(28),
//   fontWeight: FontWeight.bold,
//   color: Colors.black,
//   height: 1.5,
// );

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String incorrectEmailPass = "Incorrect email or password";
const String userNotFound = "You haven't signed up yet";
const String invalidEmail = "Invalid email address";
const String passError = "Password must have at least 8 characters";
const String emailAlreadyExist = "Your email already exists";
