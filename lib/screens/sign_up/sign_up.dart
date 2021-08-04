import 'package:flutter/material.dart';

import 'components/body.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key key}) : super(key: key);
  static String routeName = "/signUp";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }
}
