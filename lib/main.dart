import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/login/username.dart';
import '../state/token.dart';

import 'screens/login.dart';
import 'state/login/email.dart';
import 'state/login/password.dart';
import 'state/profile.dart';
import 'state/signup/first_name.dart';
import 'state/signup/last_name.dart';

void main() {
  runApp(MultiProvider(providers: [
    ListenableProvider<Password>(create: (_) => Password()),
    ListenableProvider<Email>(create: (_) => Email()),
    ListenableProvider<FirstName>(create: (_) => FirstName()),
    ListenableProvider<LastName>(create: (_) => LastName()),
    ListenableProvider<Username>(create: (_) => Username()),
    ListenableProvider<Token>(create: (_) => Token()),
    ListenableProvider<Profile>(create: (_) => Profile()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
    );
  }

  whichScreen() {}
}
