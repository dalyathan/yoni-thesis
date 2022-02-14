import 'package:flutter/material.dart';

import '../widgets/form.dart';
import '../widgets/header.dart';
import '../widgets/no_account.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double titleheightRatio = 0.075;
    double largeSpacerRatio = 0.125;
    double formHeightRatio = 0.375;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * largeSpacerRatio * 1.25,
            ),
            Center(
              child: LoginFormHead(
                height: size.height * titleheightRatio,
              ),
            ),
            SizedBox(
              height: size.height * largeSpacerRatio * 0.5,
            ),
            Center(
              child: LoginFormContainer(
                height: size.height * formHeightRatio,
              ),
            ),
            SizedBox(
              height: size.height * largeSpacerRatio * 0.25,
            ),
            Center(
              child: NoAccountContainer(
                height: size.height * 0.2,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
