import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:moneyfirst/screens/main_components/picker.dart';
import 'package:moneyfirst/screens/transactions/components/create_new_transactions/calendar.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isIncome;
  String lastClick;
  DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    isIncome = true;
    lastClick = 'date';
  }

  void setSelectedDate({DateTime selectedDate}) {
    _selectedDateTime = selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(16),
              vertical: getProportionateScreenHeight(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    'assets/icons/close-fill.svg',
                    height: getProportionateScreenHeight(24),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => print(DateTime.now().month),
                      child: SvgPicture.asset(
                        'assets/icons/file-add-line.svg',
                        height: getProportionateScreenHeight(24),
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(10),
                    ),
                    GestureDetector(
                      onTap: () => print(DateTime.now().day),
                      child: SvgPicture.asset(
                        'assets/icons/check-line.svg',
                        height: getProportionateScreenHeight(24),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          transactionTypeTab(),
          SizedBox(
            height: getProportionateScreenHeight(16),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              setter(
                icon: 'assets/icons/calendar-line.svg',
                text: DateFormat.yMMMMEEEEd().format(DateTime.now()),
                widgetSetter: Calendars(
                  changeSelectedDate: setSelectedDate,
                ),
                id: 'date',
              ),
              setter(
                icon: 'assets/icons/calendar-line.svg',
                text: DateFormat.yMMMMEEEEd().format(DateTime.now()),
                widgetSetter: Calendars(
                  changeSelectedDate: setSelectedDate,
                ),
                id: 'otong',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget setter({
    String icon,
    String text,
    Widget widgetSetter,
    String id,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              lastClick = id;
            });
          },
          child: Container(
            color: lastClick == id ? primaryColor : Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenHeight(12),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  icon,
                  fit: BoxFit.fitHeight,
                  color: lastClick == id ? Colors.white : primaryColor,
                ),
                SizedBox(
                  width: getProportionateScreenWidth(10),
                ),
                Text(
                  DateFormat.yMMMMEEEEd().format(DateTime.now()),
                  style: TextStyle(
                    color: lastClick == id ? Colors.white : Colors.black,
                    fontSize: getProportionateScreenHeight(14),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: lastClick == id,
          child: widgetSetter,
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }

  Row transactionTypeTab() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isIncome = true;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(14),
              vertical: getProportionateScreenHeight(6),
            ),
            decoration: BoxDecoration(
              color: isIncome ? primaryColor : Colors.white,
              border: Border.all(
                color: primaryColor,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  getProportionateScreenHeight(10),
                ),
                bottomLeft: Radius.circular(
                  getProportionateScreenHeight(10),
                ),
              ),
            ),
            child: Text(
              "Income",
              style: TextStyle(
                color: isIncome ? Colors.white : primaryColor,
                fontSize: getProportionateScreenHeight(14),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              isIncome = false;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(8),
              vertical: getProportionateScreenHeight(6),
            ),
            decoration: BoxDecoration(
              color: isIncome ? Colors.white : primaryColor,
              border: Border.all(
                color: primaryColor,
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(
                  getProportionateScreenHeight(10),
                ),
                bottomRight: Radius.circular(
                  getProportionateScreenHeight(10),
                ),
              ),
            ),
            child: Text(
              "Expenses",
              style: TextStyle(
                color: isIncome ? primaryColor : Colors.white,
                fontSize: getProportionateScreenHeight(14),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
