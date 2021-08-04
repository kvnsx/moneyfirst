import 'package:flutter/material.dart';

import 'components/body.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);
  static String routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
