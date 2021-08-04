import 'package:flutter/material.dart';
import 'package:moneyfirst/size_config.dart';

import 'components/body.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key key}) : super(key: key);
  static String routeName = "onboarding";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }
}
