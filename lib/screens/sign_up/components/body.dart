import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneyfirst/screens/sign_up/components/sign_up_form.dart';
import 'package:moneyfirst/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(16),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  'assets/icons/close-fill.svg',
                  height: getProportionateScreenHeight(28),
                  width: getProportionateScreenHeight(28),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            SignUpForm(),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
