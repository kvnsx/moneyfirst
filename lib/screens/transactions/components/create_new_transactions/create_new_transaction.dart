import 'package:flutter/material.dart';
import 'body.dart';

class CreateNewTransaction extends StatelessWidget {
  const CreateNewTransaction({Key key}) : super(key: key);
  static String routeName = "\createNewTransaction";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }
}
