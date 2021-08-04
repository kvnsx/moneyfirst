import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:moneyfirst/models/balance.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../size_config.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Balance balanceInfo = Provider.of<Balance>(context) ??
        Balance(
          expenses: 0,
          income: 0,
          locale: 'en',
        );
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenHeight(10),
      ),
      width: double.infinity,
      child: Container(
        height: getProportionateScreenHeight(122),
        padding: EdgeInsets.all(
          getProportionateScreenHeight(16),
        ),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(
            getProportionateScreenHeight(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Available Balance",
              style: TextStyle(
                color: Colors.white,
                fontSize: getProportionateScreenHeight(14),
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(39),
              child: Container(
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  "${NumberFormat.currency(locale: balanceInfo.locale).format(balanceInfo.income - balanceInfo.expenses)}",
                  maxLines: 1,
                  minFontSize: getProportionateScreenHeight(20),
                  stepGranularity: 0.1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getProportionateScreenHeight(26),
                    fontWeight: FontWeight.w600,
                  ),
                  overflowReplacement: AutoSizeText(
                    "${NumberFormat.compactCurrency(locale: balanceInfo.locale).format(balanceInfo.income - balanceInfo.expenses)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getProportionateScreenHeight(26),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(8),
            ),
            Row(
              children: [
                incomeOrExpenses(
                  svgPicture: 'assets/icons/arrow-up-circle-fill.svg',
                  amount:
                      "${NumberFormat.currency(locale: balanceInfo.locale).format(balanceInfo.income)}",
                  overflowText:
                      "${NumberFormat.compactCurrency(locale: balanceInfo.locale).format(balanceInfo.income)}",
                ),
                incomeOrExpenses(
                  svgPicture: 'assets/icons/arrow-down-circle-fill.svg',
                  amount:
                      "${NumberFormat.currency(locale: balanceInfo.locale).format(balanceInfo.expenses)}",
                  overflowText:
                      "${NumberFormat.compactCurrency(locale: balanceInfo.locale).format(balanceInfo.expenses)}",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded incomeOrExpenses({
    String svgPicture,
    String amount,
    String overflowText,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
          right: getProportionateScreenWidth(10),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              svgPicture,
              color: Colors.white,
              height: getProportionateScreenHeight(18),
            ),
            SizedBox(
              width: getProportionateScreenHeight(4),
            ),
            Expanded(
              child: AutoSizeText(
                amount,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: getProportionateScreenHeight(14),
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                minFontSize: getProportionateScreenHeight(14),
                overflowReplacement: AutoSizeText(
                  overflowText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getProportionateScreenHeight(14),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
