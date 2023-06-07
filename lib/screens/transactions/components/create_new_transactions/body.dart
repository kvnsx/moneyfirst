import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:moneyfirst/screens/main_components/default_button.dart';
import 'package:moneyfirst/screens/transactions/components/create_new_transactions/calendar.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  String type;
  String _selectedCategory;
  DateTime _selectedDateTime;
  String _selectedStatus;
  String _note;

  TextEditingController _controller = TextEditingController();

  String lastClick;

  @override
  void initState() {
    super.initState();
    type = 'Income';
    lastClick = 'date';

    _selectedDateTime = DateTime.now();
    _selectedStatus = 'Paid off';
  }

  void setSelectedDate({DateTime selectedDate}) {
    setState(() {
      _selectedDateTime = selectedDate;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            topBar(),
            transactionTypeTab(),
            SizedBox(
              height: getProportionateScreenHeight(24),
            ),
            category(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Row(
              children: [
                date(
                  icon: 'assets/icons/calendar-line.svg',
                  text: DateTime.now().day == _selectedDateTime.day &&
                          DateTime.now().month == _selectedDateTime.month &&
                          DateTime.now().year == _selectedDateTime.year
                      ? 'Today'
                      : DateFormat.yMMMd().format(_selectedDateTime),
                  id: 'date',
                ),
                Spacer(),
                time(
                  icon: 'assets/icons/time-line.svg',
                  text: DateFormat.jm().format(_selectedDateTime),
                  id: 'time',
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            amount(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            note(),
            status(),
            Spacer(),
            DefaultButton(
              color: primaryColor,
              text: 'ADD TRANSACTION',
              press: () {},
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            DefaultButton(
              color: primaryColor,
              text: 'ADD MORE TRANSACTIONS',
              press: () {},
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
          ],
        ),
      ),
    );
  }

  Column note() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Note',
          style: TextStyle(
            fontSize: getProportionateScreenHeight(14),
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.emailAddress,
                cursorColor: primaryColor,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      _note = value;
                    });
                  } else if (value.isEmpty) {
                    setState(() {
                      _note = null;
                    });
                  }
                },
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenHeight(14),
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  suffixIconConstraints: BoxConstraints(
                    minHeight: getProportionateScreenHeight(44),
                    minWidth: getProportionateScreenHeight(24),
                  ),
                  focusColor: Colors.white,
                  hintText: "Write here ...",
                  hintStyle: TextStyle(
                    fontSize: getProportionateScreenHeight(14),
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(11.5),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  suffixIcon: Visibility(
                    visible: _note != null,
                    child: GestureDetector(
                      onTap: () {
                        _controller.clear();
                        setState(() {
                          _note = null;
                        });
                      },
                      child: SvgPicture.asset(
                          'assets/icons/close-circle-line.svg',
                          height: getProportionateScreenHeight(24),
                          color: primaryColor),
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              indent: getProportionateScreenWidth(10),
            ),
            GestureDetector(
              child: SvgPicture.asset(
                'assets/icons/attachment-line.svg',
                color: primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
      ],
    );
  }

  Column amount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount',
          style: TextStyle(
            fontSize: getProportionateScreenHeight(14),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(6),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(
            getProportionateScreenHeight(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]),
              borderRadius: BorderRadius.circular(
                getProportionateScreenHeight(10),
              ),
            ),
            width: double.infinity,
            height: getProportionateScreenHeight(40),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  color: primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10),
                  ),
                  alignment: Alignment.center,
                  height: getProportionateScreenHeight(40),
                  child: Text(
                    'USD',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getProportionateScreenHeight(14),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column status() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Status',
          style: TextStyle(
            fontSize: getProportionateScreenHeight(14),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(6),
        ),
        Row(
          children: [
            statusOption(
              'Paid off',
              'Paid off',
            ),
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            statusOption(
              'Debt',
              'Debt',
            ),
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            statusOption(
              'Credit',
              'Credit',
            ),
          ],
        ),
      ],
    );
  }

  GestureDetector statusOption(String text, String id) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStatus = id;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(12),
          vertical: getProportionateScreenHeight(8),
        ),
        decoration: ShapeDecoration(
          shape: StadiumBorder(
            side: BorderSide(
              color: _selectedStatus == id ? primaryColor : Colors.grey,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenHeight(14),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Container category() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16),
        vertical: getProportionateScreenHeight(10),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          getProportionateScreenHeight(10),
        ),
        color: Colors.white,
        border: Border.all(
          color: primaryColor,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Category',
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(14),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Select Category',
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(14),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SvgPicture.asset(
            'assets/icons/arrow-right-s-line.svg',
          )
        ],
      ),
    );
  }

  Row topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset(
            'assets/icons/close-fill.svg',
            height: getProportionateScreenHeight(24),
          ),
        ),
        // Row(
        //   children: [
        //     GestureDetector(
        //       onTap: () => print(DateTime.now().month),
        //       child: SvgPicture.asset(
        //         'assets/icons/file-add-line.svg',
        //         height: getProportionateScreenHeight(24),
        //       ),
        //     ),
        //     SizedBox(
        //       width: getProportionateScreenWidth(10),
        //     ),
        //     GestureDetector(
        //       onTap: () => print(DateTime.now().day),
        //       child: SvgPicture.asset(
        //         'assets/icons/check-line.svg',
        //         height: getProportionateScreenHeight(24),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  Widget date({
    String icon,
    String text,
    String id,
  }) {
    return Expanded(
      flex: 12,
      child: InkWell(
        onTap: () {
          setState(() {
            lastClick = id;
          });
          showGeneralDialog(
            barrierColor: Colors.black.withOpacity(0),
            transitionDuration: Duration(milliseconds: 400),
            context: context,
            pageBuilder: (context, anim1, anim2) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    lastClick = '';
                  });
                  Navigator.pop(context);
                },
                child: Dismissible(
                  key: const Key('key'),
                  direction: DismissDirection.down,
                  onDismissed: (direcion) {
                    if (direcion == DismissDirection.down) {
                      setState(() {
                        lastClick = '';
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenHeight(10),
                              ),
                            ),
                            child: Material(
                              color: primaryColor.withOpacity(0.05),
                              child: SafeArea(
                                top: false,
                                child: Calendars(
                                  changeSelectedDate: setSelectedDate,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            transitionBuilder: (context, anim1, anim2, child) {
              return SlideTransition(
                position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                    .animate(anim1),
                child: child,
              );
            },
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(12),
            vertical: getProportionateScreenHeight(10),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              getProportionateScreenHeight(10),
            ),
            border: lastClick == id
                ? Border.all(
                    color: primaryColor,
                  )
                : null,
            color: primaryColor.withOpacity(0.05),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                color: primaryColor,
                height: getProportionateScreenHeight(20),
              ),
              Spacer(),
              Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenHeight(14),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget time({
    String icon,
    String text,
    String id,
  }) {
    return Expanded(
      flex: 10,
      child: InkWell(
        onTap: () {
          setState(() {
            lastClick = id;
          });
          showGeneralDialog(
            barrierColor: Colors.black.withOpacity(0),
            transitionDuration: Duration(milliseconds: 400),
            context: context,
            pageBuilder: (context, anim1, anim2) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    lastClick = '';
                  });
                  Navigator.pop(context);
                },
                child: Dismissible(
                  key: const Key('key'),
                  direction: DismissDirection.down,
                  onDismissed: (direcion) {
                    if (direcion == DismissDirection.down) {
                      setState(() {
                        lastClick = '';
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenHeight(10),
                              ),
                            ),
                            child: Material(
                              color: primaryColor.withOpacity(0.05),
                              child: SafeArea(
                                top: false,
                                child: Calendars(
                                  changeSelectedDate: setSelectedDate,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            transitionBuilder: (context, anim1, anim2, child) {
              return SlideTransition(
                position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                    .animate(anim1),
                child: child,
              );
            },
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(12),
            vertical: getProportionateScreenHeight(10),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              getProportionateScreenHeight(10),
            ),
            border: lastClick == id
                ? Border.all(
                    color: primaryColor,
                  )
                : null,
            color: primaryColor.withOpacity(0.05),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                color: primaryColor,
                height: getProportionateScreenHeight(20),
              ),
              Spacer(),
              Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenHeight(14),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget transactionTypeTab() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          getProportionateScreenHeight(50),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: Offset(0, 0.1),
            blurRadius: 1,
          ),
          BoxShadow(
            color: Colors.grey[50],
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(0, -0.1),
            blurRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          typeButton(
            text: 'Income',
            press: () {
              setState(() {
                type = 'Income';
              });
            },
          ),
          typeButton(
            text: 'Expenses',
            press: () {
              setState(() {
                type = 'Expenses';
              });
            },
          ),
        ],
      ),
    );
  }

  Widget typeButton({
    String text,
    Function press,
  }) {
    return Container(
      margin: EdgeInsets.all(
        getProportionateScreenHeight(4),
      ),
      child: InkWell(
        onTap: press,
        child: Container(
          padding: EdgeInsets.fromLTRB(
            getProportionateScreenWidth(16),
            getProportionateScreenHeight(4),
            getProportionateScreenHeight(16),
            getProportionateScreenWidth(6),
          ),
          decoration: type == text
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenHeight(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 4,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                    BoxShadow(
                      color: primaryColor.withOpacity(0.7),
                      offset: Offset(0, -2), // changes position of shadow
                    ),
                    BoxShadow(
                      color: primaryColor,
                    ),
                  ],
                )
              : null,
          child: Text(
            text,
            style: TextStyle(
              color: type == text ? Colors.white : primaryColor,
              fontSize: getProportionateScreenHeight(14),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
