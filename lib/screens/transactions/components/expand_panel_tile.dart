import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:moneyfirst/models/annually_summary.dart';
import 'package:moneyfirst/models/balance.dart';
import 'package:moneyfirst/models/daily_summary.dart';
import 'package:moneyfirst/models/monthly_summary.dart';
import 'package:moneyfirst/models/status_summary.dart';
import 'package:moneyfirst/models/summary.dart';
import 'package:moneyfirst/models/type_summary.dart';
import 'package:moneyfirst/screens/transactions/components/panel_list.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ExpandPanelTile extends StatefulWidget {
  final Summary data;
  final String page;
  final int index;

  const ExpandPanelTile({
    Key key,
    this.data,
    this.page,
    this.index,
  }) : super(key: key);

  @override
  _ExpandPanelTileState createState() => _ExpandPanelTileState();
}

class _ExpandPanelTileState extends State<ExpandPanelTile> {
  bool isExpanded;
  String title;
  int amount;
  int total;
  String savedPage;

  @override
  void initState() {
    super.initState();
    if (widget.index == 0) {
      isExpanded = true;
    } else {
      isExpanded = false;
    }
    savedPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final Balance localeFormat = Provider.of<Balance>(context) ??
        Balance(
          expenses: 0,
          income: 0,
          locale: 'en',
        );
    if (widget.page != savedPage) {
      setState(() {
        if (widget.index == 0) {
          isExpanded = true;
        } else {
          isExpanded = false;
        }
      });
    }
    savedPage = widget.page;
    switch (widget.page) {
      case 'Day':
        setState(() {
          title = DateFormat.yMMMMd()
              .format((widget.data as DailySummary).timestamp.toDate());
          amount = (widget.data as DailySummary).amount;
          total = (widget.data as DailySummary).total;
        });
        break;
      case 'Year':
        setState(() {
          title = DateFormat.yMMMM()
              .format((widget.data as AnnuallySummary).timestamp.toDate());
          amount = (widget.data as AnnuallySummary).amount;
          total = (widget.data as AnnuallySummary).total;
        });
        break;
      case 'Status':
        setState(() {
          title = (widget.data as StatusSummary).status;
          amount = (widget.data as StatusSummary).amount;
          total = (widget.data as StatusSummary).total;
        });
        break;
      case 'Type':
        setState(() {
          title = (widget.data as TypeSummary).type;
          amount = (widget.data as TypeSummary).amount;
          total = (widget.data as TypeSummary).total;
        });
        break;
      default:
        setState(() {
          title = DateFormat.yMMMM()
              .format((widget.data as MonthlySummary).timestamp.toDate());
          amount = (widget.data as MonthlySummary).amount;
          total = (widget.data as MonthlySummary).total;
        });
        break;
    }
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Padding(
            padding: EdgeInsets.all(
              getProportionateScreenHeight(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      title,
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    AutoSizeText(
                      "$total Transactions",
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(12),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    AutoSizeText(
                      "${NumberFormat.currency(locale: localeFormat.locale).format(amount)}",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: getProportionateScreenHeight(14),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(10),
                    ),
                    SvgPicture.asset(
                      isExpanded
                          ? 'assets/icons/arrow-up-s-line.svg'
                          : 'assets/icons/arrow-down-s-line.svg',
                      color: primaryColor,
                      height: getProportionateScreenHeight(20),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: isExpanded,
          child: Column(
            children: [
              Divider(
                height: getProportionateScreenHeight(10),
              ),
              widget.page == 'Day'
                  ? PanelList(
                      page: widget.page,
                      date: (widget.data as DailySummary).timestamp.toDate(),
                    )
                  : widget.page == 'Year'
                      ? PanelList(
                          page: widget.page,
                          date: (widget.data as AnnuallySummary)
                              .timestamp
                              .toDate(),
                        )
                      : widget.page == 'Status'
                          ? PanelList(
                              page: widget.page,
                              statusOrType:
                                  (widget.data as StatusSummary).status,
                            )
                          : widget.page == 'Type'
                              ? PanelList(
                                  page: widget.page,
                                  statusOrType:
                                      (widget.data as TypeSummary).type,
                                )
                              : PanelList(
                                  page: widget.page,
                                  date: (widget.data as MonthlySummary)
                                      .timestamp
                                      .toDate(),
                                ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
