import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'goals_list.dart';

class GoalsListView extends StatelessWidget {
  const GoalsListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Until 31 Desember 2021",
          style: TextStyle(
            fontSize: getProportionateScreenHeight(16),
            fontWeight: FontWeight.w600,
          ),
        ),
        GoalsList(),
      ],
    );
  }
}
