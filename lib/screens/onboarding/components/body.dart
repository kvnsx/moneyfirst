import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moneyfirst/constants.dart';
import 'package:moneyfirst/net/auth_service.dart';
import 'package:moneyfirst/screens/home.dart';
import 'package:moneyfirst/screens/main_components/default_button.dart';
import 'package:moneyfirst/screens/onboarding/components/contents.dart';
import 'package:moneyfirst/screens/sign_in/sign_in.dart';
import 'package:moneyfirst/screens/sign_up/sign_up.dart';
import 'package:moneyfirst/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  int savedPage = 0;
  PageController pageController = PageController(
    initialPage: 0,
  );
  Timer timer;
  List<Map<String, dynamic>> onBoardingData = [
    {
      "color": primaryColor,
      "text": "Manage income and expenses in an easy way",
      "image": "assets/images/boarding1.svg",
    },
    {
      "color": secondaryColor,
      "text": "Monitor financial developments in the desired time period",
      "image": "assets/images/boarding2.svg"
    },
    {
      "color": tertiaryColor,
      "text": "Set budget and goals conveniently",
      "image": "assets/images/boarding3.svg"
    },
  ];
  void startTimer() {
    timer = Timer.periodic(
      Duration(seconds: 5),
      (Timer timer) {
        currentPage++;
        currentPage %= onBoardingData.length;
        if (pageController.hasClients) {
          pageController.animateToPage(
            currentPage,
            duration: animationDuration,
            curve: Curves.easeIn,
          );
        }
      },
    );
  }

  void cancelTimer() {
    timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: onBoardingData[currentPage]["color"].withOpacity(0.2),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (value) => {
                setState(() {
                  if (value > 1) cancelTimer();
                  currentPage = value % onBoardingData.length;
                })
              },
              itemBuilder: (context, index) => Contents(
                color: onBoardingData[index % onBoardingData.length]["color"],
                text: onBoardingData[index % onBoardingData.length]["text"],
                image: onBoardingData[index % onBoardingData.length]["image"],
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                onBoardingData.length,
                (index) => buildDot(
                  index: index % onBoardingData.length,
                  currentPage: currentPage,
                ),
              ),
            ),
          ),
          buttonCard(context),
        ],
      ),
    );
  }

  SizedBox buttonCard(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(350),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              getProportionateScreenHeight(20),
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(16),
            ),
            child: Column(
              children: [
                Spacer(
                  flex: 2,
                ),
                DefaultButton(
                  press: () async {
                    await AuthService().signInWithGoogle();
                    Navigator.pushNamedAndRemoveUntil(
                        context, Home.routeName, (route) => false);
                  },
                  color: googleColor,
                  icon: 'assets/icons/google-fill.svg',
                  text: "CONNECT WITH GOOGLE",
                ),
                Spacer(
                  flex: 1,
                ),
                DefaultButton(
                  press: () {},
                  color: facebookColor,
                  icon: 'assets/icons/facebook-fill.svg',
                  text: "CONNECT WITH FACEBOOK",
                ),
                Spacer(
                  flex: 1,
                ),
                DefaultButton(
                  press: () {
                    cancelTimer();
                    Navigator.pushNamed(context, SignUp.routeName);
                  },
                  color: primaryColor,
                  icon: 'assets/icons/mail-fill.svg',
                  text: "SIGN UP WITH EMAIL",
                ),
                Spacer(
                  flex: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(14),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        cancelTimer();
                        Navigator.pushNamed(context, SignIn.routeName);
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(14),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(
                  flex: 2,
                ),
                Divider(
                  color: primaryColor.withOpacity(0.2),
                  thickness: getProportionateScreenHeight(1),
                ),
                Container(
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: "By continuing, you agree to Money First' ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(12),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(12),
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                          TextSpan(
                            text:
                                " and confirm that you have read Money First' ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(12),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: getProportionateScreenHeight(12),
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {}),
                          TextSpan(
                            text: ".",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(12),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index, int currentPage}) {
    return AnimatedContainer(
      duration: animationDuration,
      margin: EdgeInsets.only(right: 5),
      height: getProportionateScreenHeight(6),
      width: currentPage == index
          ? getProportionateScreenHeight(24)
          : getProportionateScreenHeight(6),
      decoration: BoxDecoration(
        color: currentPage == index
            ? onBoardingData[currentPage]["color"]
            : onBoardingData[currentPage]["color"].withOpacity(0.4),
        borderRadius: BorderRadius.circular(
          getProportionateScreenHeight(3),
        ),
      ),
    );
  }
}
