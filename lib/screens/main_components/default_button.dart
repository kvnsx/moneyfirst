import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    @required this.color,
    @required this.text,
    @required this.press,
    this.icon,
  }) : super(key: key);
  final Color color;
  final String icon, text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: press,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16),
          vertical: getProportionateScreenHeight(11.5),
        ),
        alignment: Alignment.center,
        onPrimary: Colors.white,
        primary: color,
        onSurface: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenHeight(10),
          ),
        ),
        fixedSize: Size(
          getProportionateScreenWidth(343),
          getProportionateScreenHeight(44),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          icon != null
              ? AspectRatio(
                  aspectRatio: 1,
                  child: SvgPicture.asset(
                    icon,
                    color: Colors.white,
                  ),
                )
              : SizedBox(),
          Container(
            child: Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(14),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          icon != null
              ? SizedBox(
                  width: getProportionateScreenWidth(24),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
