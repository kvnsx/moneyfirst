import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneyfirst/size_config.dart';

import 'forgot_password_form.dart';

class Body extends StatelessWidget {
  const Body({Key key, this.email}) : super(key: key);
  final String email;

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
            ForgotPasswordForm(
              email: email,
            ),
          ],
        ),
      ),
    );
  }
}
