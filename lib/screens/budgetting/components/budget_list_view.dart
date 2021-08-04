import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'budget_list.dart';

class BudgetListView extends StatelessWidget {
  const BudgetListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "18-19 July 2021",
          style: TextStyle(
            fontSize: getProportionateScreenHeight(16),
            fontWeight: FontWeight.w600,
          ),
        ),
        BudgetList(),
      ],
    );
  }
}
