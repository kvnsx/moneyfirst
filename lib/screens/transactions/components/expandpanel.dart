import 'package:flutter/material.dart';
import 'package:moneyfirst/models/annually_summary.dart';
import 'package:moneyfirst/models/monthly_summary.dart';
import 'package:moneyfirst/models/daily_summary.dart';
import 'package:moneyfirst/models/status_summary.dart';
import 'package:moneyfirst/models/type_summary.dart';
import 'package:provider/provider.dart';

import 'expand_panel_tile.dart';

class ExpandPanel extends StatelessWidget {
  final String page;

  const ExpandPanel({
    Key key,
    @required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dailySummaries = Provider.of<List<DailySummary>>(context) ?? [];
    final monthlySummaries = Provider.of<List<MonthlySummary>>(context) ?? [];
    final annuallySummaries = Provider.of<List<AnnuallySummary>>(context) ?? [];
    final statusSummaries = Provider.of<List<StatusSummary>>(context) ?? [];
    final typeSummaries = Provider.of<List<TypeSummary>>(context) ?? [];
    switch (page) {
      case 'Day':
        return ListView.builder(
          shrinkWrap: true,
          itemCount: dailySummaries.length,
          itemBuilder: (context, index) {
            return ExpandPanelTile(
              data: dailySummaries[index],
              page: page,
              index: index,
            );
          },
        );
        break;
      case 'Year':
        return ListView.builder(
          shrinkWrap: true,
          itemCount: annuallySummaries.length,
          itemBuilder: (context, index) {
            return ExpandPanelTile(
              data: annuallySummaries[index],
              page: page,
              index: index,
            );
          },
        );
        break;
      case 'Status':
        return ListView.builder(
          shrinkWrap: true,
          itemCount: statusSummaries.length,
          itemBuilder: (context, index) {
            return ExpandPanelTile(
              data: statusSummaries[index],
              page: page,
              index: index,
            );
          },
        );
        break;
      case 'Type':
        return ListView.builder(
          shrinkWrap: true,
          itemCount: typeSummaries.length,
          itemBuilder: (context, index) {
            return ExpandPanelTile(
              data: typeSummaries[index],
              page: page,
              index: index,
            );
          },
        );
        break;
      default:
        return ListView.builder(
          shrinkWrap: true,
          itemCount: monthlySummaries.length,
          itemBuilder: (context, index) {
            return ExpandPanelTile(
              data: monthlySummaries[index],
              page: page,
              index: index,
            );
          },
        );
    }
  }
}
