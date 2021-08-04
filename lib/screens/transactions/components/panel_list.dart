import 'package:flutter/material.dart';
import 'package:moneyfirst/models/record.dart';
import 'package:moneyfirst/screens/transactions/components/panel_tile.dart';
import 'package:provider/provider.dart';

class PanelList extends StatelessWidget {
  final String page;
  final DateTime date;
  final String statusOrType;

  const PanelList({
    Key key,
    this.page,
    this.date,
    this.statusOrType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final records = Provider.of<List<Record>>(context) ?? [];
    int itemCount = 0;
    List<Record> item = [];

    switch (page) {
      case 'Day':
        itemCount = records
            .where((element) =>
                element.timestamp.toDate().day == date.day &&
                element.timestamp.toDate().month == date.month &&
                element.timestamp.toDate().year == date.year)
            .length;
        item = records
            .where((element) =>
                element.timestamp.toDate().day == date.day &&
                element.timestamp.toDate().month == date.month &&
                element.timestamp.toDate().year == date.year)
            .toList();
        break;
      case 'Year':
        itemCount = records
            .where((element) => element.timestamp.toDate().year == date.year)
            .length;
        item = records
            .where((element) => element.timestamp.toDate().year == date.year)
            .toList();
        break;
      case 'Status':
        itemCount = records
            .where((element) =>
                element.status.toLowerCase() == statusOrType.toLowerCase())
            .length;
        item = records
            .where((element) =>
                element.status.toLowerCase() == statusOrType.toLowerCase())
            .toList();
        break;
      case 'Type':
        itemCount = records
            .where((element) =>
                element.type.toLowerCase() == statusOrType.toLowerCase())
            .length;
        item = records
            .where((element) =>
                element.type.toLowerCase() == statusOrType.toLowerCase())
            .toList();
        break;
      default:
        itemCount = records
            .where((element) =>
                element.timestamp.toDate().month == date.month &&
                element.timestamp.toDate().year == date.year)
            .length;
        item = records
            .where((element) =>
                element.timestamp.toDate().month == date.month &&
                element.timestamp.toDate().year == date.year)
            .toList();
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return PanelTile(
          data: item[index],
          page: page,
        );
      },
    );
  }
}
