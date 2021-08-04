import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneyfirst/models/balance.dart';
import 'package:moneyfirst/models/record.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class PanelTile extends StatelessWidget {
  PanelTile({
    Key key,
    this.page,
    this.data,
  }) : super(key: key);

  final String page;
  final Record data;

  @override
  Widget build(BuildContext context) {
    final Balance localeFormat = Provider.of<Balance>(context) ??
        Balance(
          expenses: 0,
          income: 0,
          locale: 'en',
        );
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(
          getProportionateScreenHeight(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: getProportionateScreenHeight(38),
                  width: getProportionateScreenHeight(4),
                  decoration: BoxDecoration(
                    color: Color(int.parse('0xFFFFDA22')),
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenHeight(2),
                    ),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(10),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      data.category,
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    AutoSizeText(
                      data.status,
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(12),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AutoSizeText(
                  "${NumberFormat.currency(locale: localeFormat.locale).format(data.amount)}",
                  style: TextStyle(
                    color: data.type.toLowerCase() == 'income'
                        ? secondaryColor
                        : tertiaryColor,
                    fontSize: getProportionateScreenHeight(14),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.end,
                ),
                AutoSizeText(
                  page == 'Day'
                      ? "${DateFormat.jm().format(data.timestamp.toDate())}"
                      : "${DateFormat.yMMMMd().format(data.timestamp.toDate())}",
                  // DateFormat.yMMMMd('en_US').format(),
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(12),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflowReplacement: AutoSizeText(
                    "${NumberFormat.compactCurrency(locale: localeFormat.locale).format(data.amount)}",
                    style: TextStyle(
                      color: data.type.toLowerCase() == 'income'
                          ? secondaryColor
                          : tertiaryColor,
                      fontSize: getProportionateScreenHeight(14),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
