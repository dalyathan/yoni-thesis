import 'package:yoni_thesis/screens/dashboard.dart';
import 'package:yoni_thesis/services/api.dart';
import 'package:yoni_thesis/state/login/username.dart';

import '../models/account.dart';
import '../state/profile.dart';
import '../state/token.dart';
import '/state/login/password.dart';
import '/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../state/login/email.dart';
import 'button.dart';
import 'textfield.dart';
import 'dart:convert';

class LoginFormContainer extends StatefulWidget {
  final double height;
  const LoginFormContainer({Key? key, required this.height}) : super(key: key);

  @override
  State<LoginFormContainer> createState() => _LoginFormContainerState();
}

class _LoginFormContainerState extends State<LoginFormContainer> {
  final _formKey = GlobalKey<FormState>();
  late Username usernameProvider;
  late Password passwordProvider;
  late Token token;
  late Profile profile;
  bool isLoading = false;
  bool invalidCredential = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        usernameProvider = Provider.of<Username>(context, listen: false);
        passwordProvider = Provider.of<Password>(context, listen: false);
        token = Provider.of<Token>(context, listen: false);
        profile = Provider.of<Profile>(context, listen: false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double textfieldHeight = 0.2 * widget.height;
    double textfieldWidth = size.width * 0.8;
    return SizedBox(
      height: widget.height,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextfieldContainer(
              height: textfieldHeight,
              width: textfieldWidth,
              providerUpdater: (value) => usernameProvider.setUsername(value),
              hintText: 'Username',
            ),
            const Spacer(
              flex: 2,
            ),
            TextfieldContainer(
              height: textfieldHeight,
              width: textfieldWidth,
              isPasswordField: true,
              providerUpdater: (value) => passwordProvider.setPassword(value),
              hintText: 'Password',
            ),
            const Spacer(
              flex: 1,
            ),
            SizedBox(
              width: textfieldWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: textfieldWidth * 0.4,
                    height: widget.height * 0.05,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: invalidCredential
                          ? FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                "Invalid Credentials",
                                style: GoogleFonts.sora(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600),
                              ))
                          : Container(),
                    ),
                  ),
                  SizedBox(
                    height: widget.height * 0.05,
                    width: textfieldWidth * 0.4,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          "Forgot Password?",
                          style: GoogleFonts.sora(
                              decoration: TextDecoration.underline,
                              color: MyTheme.darkBlue,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(
              flex: 5,
            ),
            isLoading
                ? const SizedBox.square(
                    dimension: 30, child: CircularProgressIndicator())
                : CustomButton(
                    height: textfieldHeight * 0.9,
                    width: textfieldWidth,
                    description: 'Login',
                    onPressed: onLogin,
                  )
          ],
        ),
      ),
    );
  }

  onLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      var response =
          await Api.login(usernameProvider.username, passwordProvider.password);
      setState(() {
        isLoading = false;
      });
      clearFields();
      if (response['status'] as int == 200) {
        var reply = jsonDecode(response['message']);
        token.setToken(reply['access']);
        var accountData = await Api.profile(reply['access']);
        if (accountData['status'] as int == 200) {
          var decoded = jsonDecode(accountData['message']);
          print(decoded['first_name']);
          profile.setAccount(Account.fromJson(decoded));
          setState(() {
            isLoading = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Dashboard()),
          );
        } else {
          setState(() {
            isLoading = false;
          });
          toast(accountData['message'] as String);
        }
      } else {
        setState(() {
          isLoading = false;
        });
        toast(jsonDecode(response['message'])['detail'] as String);
      }
      // print(response['status']);
      // print(jsonDecode(response['message']));
    }
  }

  toast(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    // snackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  clearFields() {
    usernameProvider.setUsername('');
    passwordProvider.setPassword('');
  }
}
