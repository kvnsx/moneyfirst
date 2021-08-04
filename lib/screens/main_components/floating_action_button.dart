import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import '../../size_config.dart';

class FloatingActionButtons extends StatelessWidget {
  const FloatingActionButtons({
    Key key,
    @required this.press,
  }) : super(key: key);
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: getProportionateScreenHeight(32),
      right: 0,
      child: FloatingActionButton(
        foregroundColor: primaryColor,
        backgroundColor: primaryColor,
        onPressed: press,
        child: SvgPicture.asset(
          'assets/icons/add-fill.svg',
          color: Colors.white,
          height: getProportionateScreenHeight(28),
        ),
      ),
    );
  }
}
