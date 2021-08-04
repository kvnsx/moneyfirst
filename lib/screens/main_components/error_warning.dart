import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneyfirst/constants.dart';
import 'package:moneyfirst/size_config.dart';

class ErrorWarning extends StatelessWidget {
  const ErrorWarning({
    Key key,
    this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(32),
      alignment: Alignment.bottomLeft,
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/error-warning-fill.svg',
            height: getProportionateScreenHeight(18),
            color: tertiaryColor,
          ),
          SizedBox(
            width: getProportionateScreenHeight(8),
          ),
          Text(
            text,
            style: TextStyle(
              color: tertiaryColor,
              fontSize: getProportionateScreenHeight(12),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
