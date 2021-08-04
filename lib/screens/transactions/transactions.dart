import 'package:moneyfirst/constants.dart';
import 'package:moneyfirst/screens/main_components/floating_action_button.dart';
import 'package:moneyfirst/screens/transactions/components/dropdown_period.dart';
import 'package:moneyfirst/screens/transactions/components/expandpanel.dart';
import 'package:moneyfirst/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'components/create_new_transactions/create_new_transaction.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key key}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  bool isOverlayOpened;
  String _currentPage = "All";
  List<ExpansionPanel> transactionLists = [];
  String dropdownValue;
  var dropdownItems = [
    'Day',
    'Month',
    'Year',
    'Status',
    'Type',
  ];

  @override
  void initState() {
    super.initState();
    isOverlayOpened = false;
    _currentPage = "All";
    dropdownValue = dropdownItems[1];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        getProportionateScreenWidth(16),
        getProportionateScreenHeight(10),
        getProportionateScreenWidth(16),
        0,
      ),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(40),
              ),
              ExpandPanel(
                page: dropdownValue,
              ),
            ],
          ),
          transactionTabBar(),
          FloatingActionButtons(
            press: () {
              Navigator.pushNamed(context, CreateNewTransaction.routeName);
            },
          ),
        ],
      ),
    );
  }

  Container transactionTabBar() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenHeight(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          dropdownButton(),
          iconOnTab(),
        ],
      ),
    );
  }

  DropdownPeriod<int> dropdownButton() {
    return DropdownPeriod(
      child: Row(
        children: [
          Text(
            "Group by ",
            style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenHeight(14),
                fontWeight: FontWeight.w400),
          ),
          Text(
            dropdownValue,
            style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenHeight(14),
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
      onChanged: (int value, int index) {
        setState(() {
          dropdownValue = dropdownItems[value - 1];
        });
      },
      items: dropdownItems
          .asMap()
          .entries
          .map(
            (item) => DropdownItem<int>(
              value: item.key + 1,
              text: Text(
                item.value,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenHeight(14),
                    fontWeight: FontWeight.w400),
              ),
            ),
          )
          .toList(),
    );
  }

  Row iconOnTab() {
    return Row(
      children: [
        icon('assets/icons/equalizer-line.svg'),
        SizedBox(
          width: getProportionateScreenWidth(20),
        ),
        icon('assets/icons/search-line.svg'),
      ],
    );
  }

  SizedBox icon(String svgPicture) {
    return SizedBox(
      height: getProportionateScreenHeight(20),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          child: GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              svgPicture,
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector filterTab(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentPage = text;
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(
            getProportionateScreenWidth(10),
            getProportionateScreenHeight(7.5),
            getProportionateScreenWidth(10),
            getProportionateScreenHeight(7.5)),
        decoration: BoxDecoration(
          color: text == _currentPage ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(getProportionateScreenHeight(10)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: text == _currentPage ? Colors.white : primaryColor,
            fontSize: getProportionateScreenHeight(14),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
