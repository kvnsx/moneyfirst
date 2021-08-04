import 'package:moneyfirst/screens/goals/components/goals_list_view.dart';
import 'package:moneyfirst/size_config.dart';
import 'package:flutter/material.dart';

class Goals extends StatefulWidget {
  const Goals({Key key}) : super(key: key);

  @override
  _GoalsState createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        getProportionateScreenWidth(16),
        getProportionateScreenHeight(20),
        getProportionateScreenWidth(16),
        0,
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: GoalsListView(),
          ),
          // FloatingActionButtons(),
        ],
      ),
    );
  }
}
