import 'package:flutter/material.dart';

import 'components/body.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key key}) : super(key: key);
  static String routeName = "/signIn";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }
}
