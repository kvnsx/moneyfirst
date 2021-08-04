import 'package:flutter/material.dart';

import 'components/body.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key key, this.email}) : super(key: key);
  static String routeName = "/forgotPassword";
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Body(email: email),
    );
  }
}
