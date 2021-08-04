import 'package:firebase_core/firebase_core.dart';
import 'package:moneyfirst/routes.dart';
import 'package:moneyfirst/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'net/auth_service.dart';
import 'wrapper.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().onAuthStateChanged,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'moneyfirst: Money Manager and Budget Planner',
        theme: theme(),
        routes: routes,
        initialRoute: Wrapper.routeName,
      ),
    );
  }
}
