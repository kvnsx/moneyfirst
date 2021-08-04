import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneyfirst/net/auth_service.dart';
import 'package:moneyfirst/screens/main_components/default_button.dart';
import 'package:moneyfirst/screens/main_components/picker.dart';
import 'package:moneyfirst/screens/onboarding/onboarding.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          getProportionateScreenWidth(16),
          getProportionateScreenHeight(16),
          getProportionateScreenWidth(16),
          0,
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              width: double.infinity,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  'assets/icons/close-fill.svg',
                  height: getProportionateScreenHeight(28),
                ),
              ),
            ),
            Text(
              "Your Profile",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenHeight(22),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: getProportionateScreenHeight(24),
            ),
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/icons/account.svg',
                height: getProportionateScreenHeight(84),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Picker(
              title: "Date",
              initialValue: "",
              press: () async {
                final DateTime picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: ColorScheme.light(
                          primary: primaryColor,
                          onPrimary: Colors.white,
                          onSurface: Colors.black,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                              fontSize: getProportionateScreenHeight(14),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      child: child,
                    );
                  },
                );
              },
            ),
            DefaultButton(
              color: primaryColor,
              text: "SIGN OUT",
              press: () {
                _auth.signOut();
                _auth.signOutFromGoogle();
                Navigator.pushNamedAndRemoveUntil(
                    context, OnBoarding.routeName, (route) => false);
              },
              icon: 'assets/icons/logout-box-fill.svg',
            ),
          ],
        ),
      ),
    );
  }
}
