import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneyfirst/net/auth_service.dart';
import 'package:moneyfirst/screens/home.dart';
import 'package:moneyfirst/screens/main_components/default_button.dart';
import 'package:moneyfirst/screens/main_components/error_warning.dart';
import 'package:moneyfirst/screens/main_components/keyboard_util.dart';
import 'package:moneyfirst/screens/sign_in/sign_in.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key key,
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email, password, emailErrorText, passErrorText;
  bool isHide, showEmailError, showPassError;
  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    super.initState();
    isHide = true;
    showEmailError = false;
    showPassError = false;
    emailErrorText = invalidEmail;
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
      key: _formKey,
      child: Column(
        children: [
          Text(
            "Sign Up",
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
          Visibility(
            visible: showEmailError,
            child: ErrorWarning(text: emailErrorText),
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
            visible: showPassError,
            child: ErrorWarning(text: passError),
          ),
          SizedBox(
            height: getProportionateScreenHeight(24),
          ),
          DefaultButton(
            color: primaryColor,
            text: "SIGN UP",
            press: email != null && password != null
                ? () async {
                    if (emailValidatorRegExp.hasMatch(email) &&
                        password.length > 7) {
                      dynamic result = await _auth.signUp(
                        email: email,
                        password: password,
                      );
                      print(result);
                      if (result == "success") {
                        KeyboardUtil.hideKeyboard(context);
                        Navigator.pushNamedAndRemoveUntil(
                            context, Home.routeName, (route) => false);
                      } else if (result == "email-already-in-use") {
                        setState(() {
                          emailErrorText = emailAlreadyExist;
                          showEmailError = true;
                        });
                      } else if (result == "invalid-email") {
                        setState(() {
                          emailErrorText = invalidEmail;
                          showEmailError = true;
                        });
                      }
                    } else if (!emailValidatorRegExp.hasMatch(email) &&
                        password.length < 8) {
                      setState(() {
                        emailErrorText = invalidEmail;
                        passErrorText = passError;
                        showEmailError = true;
                        showPassError = true;
                      });
                    } else if (!emailValidatorRegExp.hasMatch(email)) {
                      setState(() {
                        emailErrorText = invalidEmail;
                        showEmailError = true;
                      });
                    } else if (password.length < 8) {
                      setState(() {
                        passErrorText = passError;
                        showPassError = true;
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
                "Already have an account? ",
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(14),
                  fontWeight: FontWeight.w400,
                ),
              ),
              GestureDetector(
                onTap: () {
                  KeyboardUtil.hideKeyboard(context);
                  Navigator.pushReplacementNamed(context, SignIn.routeName);
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
        if (showEmailError) {
          setState(() {
            showEmailError = false;
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
            color: showEmailError ? tertiaryColor : primaryColor,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: showEmailError
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
      keyboardType: TextInputType.emailAddress,
      cursorColor: primaryColor,
      obscureText: isHide,
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
        if (showPassError) {
          setState(() {
            passErrorText = passError;
            showPassError = false;
          });
        }
      },
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(" ")),
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
            color: showPassError ? tertiaryColor : primaryColor,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color:
                showPassError ? tertiaryColor : primaryColor.withOpacity(0.5),
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
