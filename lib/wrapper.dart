import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';
import 'screens/onboarding/onboarding.dart';

class Wrapper extends StatelessWidget {
  static String routeName = "/wrapper";

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    if (user == null) {
      return OnBoarding();
    } else {
      return Home();
    }
  }
}
