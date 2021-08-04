import 'package:moneyfirst/screens/forgot_password/forgot_password.dart';
import 'package:moneyfirst/screens/home.dart';
import 'package:moneyfirst/screens/onboarding/onboarding.dart';
import 'package:moneyfirst/screens/profile/profile.dart';
import 'package:moneyfirst/screens/transactions/components/create_new_transactions/create_new_transaction.dart';
import 'package:flutter/widgets.dart';
import 'package:moneyfirst/wrapper.dart';

import 'screens/sign_in/sign_in.dart';
import 'screens/sign_up/sign_up.dart';

final Map<String, WidgetBuilder> routes = {
  Wrapper.routeName: (context) => Wrapper(),
  OnBoarding.routeName: (context) => OnBoarding(),
  SignUp.routeName: (context) => SignUp(),
  SignIn.routeName: (context) => SignIn(),
  ForgotPassword.routeName: (context) => ForgotPassword(),
  Home.routeName: (context) => Home(),
  Profile.routeName: (context) => Profile(),
  CreateNewTransaction.routeName: (context) => CreateNewTransaction(),
};
