import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:moneyfirst/net/auth_service.dart';
import 'package:moneyfirst/screens/main_components/default_button.dart';
import 'package:moneyfirst/screens/main_components/error_warning.dart';
import 'package:moneyfirst/screens/main_components/keyboard_util.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key key, this.email}) : super(key: key);
  final String email;

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final AuthService _auth = AuthService();
  String email;
  FocusNode focusNode = FocusNode();
  TextEditingController textController;
  final _formKey = GlobalKey<FormState>();
  bool showError;

  @override
  void initState() {
    super.initState();
    showError = false;
    if (widget.email != null && emailValidatorRegExp.hasMatch(widget.email)) {
      this.email = widget.email;
      textController = new TextEditingController(
        text: widget.email,
      );
    } else {
      this.email = null;
      textController = new TextEditingController();
    }
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            "Reset Password",
            style: TextStyle(
              fontSize: getProportionateScreenHeight(22),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(60),
          ),
          emailTextField(
            focusNode: focusNode,
            prefixIcon: 'assets/icons/mail-fill.svg',
            suffixIcon: 'assets/icons/close-circle-line.svg',
            text: "Email Address",
          ),
          Visibility(
            visible: showError,
            child: ErrorWarning(
              text: invalidEmail,
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(24),
          ),
          DefaultButton(
            color: primaryColor,
            text: "RESET PASSWORD",
            press: email != null
                ? () async {
                    if (!emailValidatorRegExp.hasMatch(email)) {
                      setState(() {
                        showError = true;
                      });
                    } else {
                      _auth.resetPassword(email);
                      KeyboardUtil.hideKeyboard(context);
                      Navigator.pop(context);
                    }
                  }
                : null,
          ),
        ],
      ),
    );
  }

  TextFormField emailTextField({
    FocusNode focusNode,
    String prefixIcon,
    String text,
    String suffixIcon,
    String initialValue,
  }) {
    return TextFormField(
      focusNode: focusNode,
      keyboardType: TextInputType.emailAddress,
      cursorColor: primaryColor,
      autofocus: true,
      controller: textController,
      onSaved: (newValue) => email = newValue,
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
        suffixIcon: Visibility(
          visible: email != null,
          child: GestureDetector(
            onTap: () {
              textController.clear();
              setState(() {
                showError = false;
                email = null;
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
      ),
    );
  }
}
