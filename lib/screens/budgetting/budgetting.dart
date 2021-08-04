import 'package:flutter/material.dart';

import '../../size_config.dart';
import 'components/budget_list_view.dart';

class Budgetting extends StatefulWidget {
  const Budgetting({Key key}) : super(key: key);

  @override
  _BudgettingState createState() => _BudgettingState();
}

class _BudgettingState extends State<Budgetting> {
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
            child: BudgetListView(),
          ),
          // FloatingActionButtons(),
        ],
      ),
    );
  }
}
