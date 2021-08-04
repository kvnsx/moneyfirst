import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import '../../size_config.dart';

class Picker extends StatelessWidget {
  const Picker(
      {Key key,
      @required this.title,
      @required this.initialValue,
      @required this.press})
      : super(key: key);
  final String title, initialValue;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: getProportionateScreenHeight(14),
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Text(
                  initialValue,
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(14),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.end,
                ),
                SizedBox(
                  width: getProportionateScreenWidth(10),
                ),
                SvgPicture.asset(
                  'assets/icons/arrow-right-s-line.svg',
                  color: primaryColor,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
