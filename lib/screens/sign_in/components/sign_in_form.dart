import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneyfirst/net/auth_service.dart';
import 'package:moneyfirst/screens/forgot_password/forgot_password.dart';
import 'package:moneyfirst/screens/home.dart';
import 'package:moneyfirst/screens/main_components/default_button.dart';
import 'package:moneyfirst/screens/main_components/error_warning.dart';
import 'package:moneyfirst/screens/main_components/keyboard_util.dart';
import 'package:moneyfirst/screens/sign_up/sign_up.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key key,
  }) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final AuthService _auth = AuthService();
  String email, password, errorText;
  bool isHide, showError;
  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    super.initState();
    isHide = true;
    errorText = incorrectEmailPass;
    showError = false;
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _focusNodes.forEach((node) {
      node.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Text(
            "Sign In",
            style: TextStyle(
              fontSize: getProportionateScreenHeight(22),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(60),
          ),
          emailTextField(
            focusNode: _focusNodes[0],
            prefixIcon: 'assets/icons/mail-fill.svg',
            text: "Email Address",
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          passwordTextField(
            focusNode: _focusNodes[1],
            prefixIcon: 'assets/icons/lock-fill.svg',
            suffixIcon: isHide
                ? 'assets/icons/eye-off-line.svg'
                : 'assets/icons/eye-line.svg',
            text: "Password",
          ),
          Visibility(
            visible: showError,
            child: ErrorWarning(
              text: errorText,
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          GestureDetector(
            onTap: () {
              KeyboardUtil.hideKeyboard(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ForgotPassword(
                    email: email,
                  ),
                ),
              );
            },
            child: Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(14),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(24),
          ),
          DefaultButton(
            color: primaryColor,
            text: "SIGN IN",
            press: email != null && password != null
                ? () async {
                    if (emailValidatorRegExp.hasMatch(email) &&
                        password.length > 7) {
                      dynamic result = await _auth.signIn(
                        email: email,
                        password: password,
                      );
                      print(result);
                      if (result == "success") {
                        KeyboardUtil.hideKeyboard(context);
                        Navigator.pushNamedAndRemoveUntil(
                            context, Home.routeName, (route) => false);
                      } else if (result == "user-not-found") {
                        setState(() {
                          errorText = userNotFound;
                          showError = true;
                        });
                      } else {
                        setState(() {
                          errorText = incorrectEmailPass;
                          showError = true;
                        });
                      }
                    } else {
                      setState(() {
                        errorText = incorrectEmailPass;
                        showError = true;
                      });
                    }
                  }
                : null,
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(14),
                  fontWeight: FontWeight.w400,
                ),
              ),
              GestureDetector(
                onTap: () {
                  KeyboardUtil.hideKeyboard(context);
                  Navigator.pushReplacementNamed(context, SignUp.routeName);
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(14),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextFormField emailTextField({
    FocusNode focusNode,
    String prefixIcon,
    String text,
  }) {
    return TextFormField(
      focusNode: focusNode,
      keyboardType: TextInputType.emailAddress,
      cursorColor: primaryColor,
      autofocus: true,
      autocorrect: false,
      enableSuggestions: true,
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() {
            email = value;
          });
        } else if (value.isEmpty) {
          setState(() {
            email = null;
          });
        }
        if (showError) {
          setState(() {
            showError = false;
          });
        }
      },
      inputFormatters: [
        FilteringTextInputFormatter.deny(
          RegExp(" "),
        ),
      ],
      style: TextStyle(
        color: Colors.black,
        fontSize: getProportionateScreenHeight(14),
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        prefixIconConstraints: BoxConstraints(
            minHeight: getProportionateScreenHeight(44),
            minWidth: getProportionateScreenHeight(24)),
        focusColor: Colors.white,
        hintText: text,
        hintStyle: TextStyle(
          fontSize: getProportionateScreenHeight(16),
          fontWeight: FontWeight.w400,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(11.5),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: showError ? tertiaryColor : primaryColor,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: showError
                ? tertiaryColor.withOpacity(0.5)
                : primaryColor.withOpacity(0.5),
          ),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            getProportionateScreenHeight(12),
            getProportionateScreenWidth(10),
            getProportionateScreenHeight(12),
          ),
          child: SvgPicture.asset(
            prefixIcon,
            height: getProportionateScreenHeight(24),
            color: focusNode.hasFocus
                ? primaryColor
                : primaryColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  TextFormField passwordTextField({
    FocusNode focusNode,
    String prefixIcon,
    String suffixIcon,
    String text,
  }) {
    return TextFormField(
      focusNode: focusNode,
      keyboardType: TextInputType.text,
      cursorColor: primaryColor,
      obscureText: isHide,
      autocorrect: false,
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() {
            password = value;
          });
        } else if (value.isEmpty) {
          setState(() {
            password = null;
          });
        }
        if (showError) {
          setState(() {
            showError = false;
          });
        }
      },
      inputFormatters: [
        FilteringTextInputFormatter.deny(
          RegExp(" "),
        ),
      ],
      style: TextStyle(
        color: Colors.black,
        fontSize: getProportionateScreenHeight(14),
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        prefixIconConstraints: BoxConstraints(
          minHeight: getProportionateScreenHeight(44),
          minWidth: getProportionateScreenHeight(24),
        ),
        suffixIconConstraints: BoxConstraints(
          minHeight: getProportionateScreenHeight(44),
          minWidth: getProportionateScreenHeight(24),
        ),
        focusColor: Colors.white,
        hintText: text,
        hintStyle: TextStyle(
          fontSize: getProportionateScreenHeight(16),
          fontWeight: FontWeight.w400,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(11.5),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: showError ? tertiaryColor : primaryColor,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: showError
                ? tertiaryColor.withOpacity(0.5)
                : primaryColor.withOpacity(0.5),
          ),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            getProportionateScreenHeight(12),
            getProportionateScreenWidth(10),
            getProportionateScreenHeight(12),
          ),
          child: SvgPicture.asset(
            prefixIcon,
            height: getProportionateScreenHeight(24),
            color: focusNode.hasFocus
                ? primaryColor
                : primaryColor.withOpacity(0.5),
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isHide = !isHide;
            });
          },
          child: SvgPicture.asset(
            suffixIcon,
            height: getProportionateScreenHeight(24),
            color: focusNode.hasFocus
                ? primaryColor
                : primaryColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
