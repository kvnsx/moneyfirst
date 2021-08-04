import 'package:flutter/material.dart';

import '../../size_config.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          getProportionateScreenWidth(16),
          getProportionateScreenHeight(20),
          getProportionateScreenWidth(16),
          0,
        ),
        child: Container(color: Colors.red),
      ),
    );
  }
}
