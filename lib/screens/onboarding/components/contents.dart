import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../size_config.dart';

class Contents extends StatelessWidget {
  const Contents({
    Key key,
    @required this.text,
    @required this.image,
    @required this.color,
  }) : super(key: key);
  final String text, image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: getProportionateScreenHeight(28),
            ),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: getProportionateScreenHeight(22),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: SvgPicture.asset(
                  image,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
