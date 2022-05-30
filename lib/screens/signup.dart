import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yoni_thesis/models/SignUp.dart';
import 'package:yoni_thesis/screens/login.dart';
import 'package:yoni_thesis/services/api.dart';
import 'package:yoni_thesis/state/login/username.dart';

import '../state/login/email.dart';
import '../state/login/password.dart';
import '../state/signup/first_name.dart';
import '../state/signup/last_name.dart';
import '../widgets/button.dart';
import '../widgets/textfield.dart';

class SignupRoute extends StatefulWidget {
  const SignupRoute({Key? key}) : super(key: key);

  @override
  _SignupRouteState createState() => _SignupRouteState();
}

class _SignupRouteState extends State<SignupRoute> {
  final _formKey = GlobalKey<FormState>();
  late FirstName firstNameProvider;
  late LastName lastNameProvider;
  late Password passwordProvider;
  late Email emailProvider;
  late Username usernameProvider;
  bool passwordRetyped = false;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        firstNameProvider = Provider.of<FirstName>(context, listen: false);
        lastNameProvider = Provider.of<LastName>(context, listen: false);
        emailProvider = Provider.of<Email>(context, listen: false);
        usernameProvider = Provider.of<Username>(context, listen: false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double titleheightRatio = 0.05;
    double largeSpacerRatio = 0.1;
    double smallSpacerRatio = 0.035;
    double textfieldHeight = size.height * 0.075;
    double textfieldWidth = size.width * 0.8;
    passwordProvider = Provider.of<Password>(context, listen: true);
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: (size.width - textfieldWidth) / 2),
          child: Column(
            children: [
              SizedBox(
                height: size.height * largeSpacerRatio,
              ),
              SizedBox(
                height: size.height * titleheightRatio,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    "Signup",
                    style: GoogleFonts.sora(
                        color: const Color.fromRGBO(73, 135, 185, 1),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * smallSpacerRatio,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextfieldContainer(
                        height: textfieldHeight,
                        width: textfieldWidth,
                        hintText: 'First name',
                        regexPattern: '^[A-Za-z]+\$',
                        matchFailedMessage:
                            'name must be alphabets and no space',
                        providerUpdater: (name) =>
                            firstNameProvider.setFirstName(name)),
                    SizedBox(
                      height: size.height * smallSpacerRatio,
                    ),
                    TextfieldContainer(
                        height: textfieldHeight,
                        width: textfieldWidth,
                        hintText: 'Last name',
                        regexPattern: '^[A-Za-z]+\$',
                        matchFailedMessage:
                            'name must be alphabets and no space',
                        providerUpdater: (name) =>
                            lastNameProvider.setLastName(name)),
                    SizedBox(
                      height: size.height * smallSpacerRatio,
                    ),
                    TextfieldContainer(
                      height: textfieldHeight,
                      width: textfieldWidth,
                      providerUpdater: (value) =>
                          usernameProvider.setUsername(value),
                      hintText: 'Username',
                      regexPattern: '^[a-zA-Z0-9.a-zA-Z0-9]+\$',
                      matchFailedMessage: 'Incorrect username format',
                    ),
                    SizedBox(
                      height: size.height * smallSpacerRatio,
                    ),
                    TextfieldContainer(
                      height: textfieldHeight,
                      width: textfieldWidth,
                      providerUpdater: (value) => emailProvider.setEmail(value),
                      hintText: 'Email',
                      regexPattern:
                          '^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&\'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\\.[a-zA-Z]+',
                      matchFailedMessage: 'Incorrect email format',
                    ),
                    SizedBox(
                      height: size.height * smallSpacerRatio,
                    ),
                    TextfieldContainer(
                      height: textfieldHeight,
                      width: textfieldWidth,
                      isPasswordField: true,
                      providerUpdater: (value) =>
                          passwordProvider.setPassword(value),
                      regexPattern: '^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}\$',
                      matchFailedMessage:
                          'minimum eight, atleast one letter and one number',
                      hintText: 'Password',
                    ),
                    SizedBox(
                      height: size.height * smallSpacerRatio,
                    ),
                    TextfieldContainer(
                      height: textfieldHeight,
                      width: textfieldWidth,
                      isPasswordField: true,
                      providerUpdater: (_) => setState(() {
                        passwordRetyped = true;
                      }),
                      regexPattern: '^${passwordProvider.password}\$',
                      matchFailedMessage: 'passwords must match',
                      hintText: 'Retype Password',
                    ),
                    SizedBox(
                      height: size.height * smallSpacerRatio,
                    ),
                    isLoading
                        ? const SizedBox.square(
                            dimension: 30, child: CircularProgressIndicator())
                        : CustomButton(
                            width: textfieldWidth,
                            height: textfieldHeight * 0.9,
                            description: 'Signup',
                            onPressed: signup)
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  signup() async {
    if (_formKey.currentState!.validate() && passwordRetyped) {
      SignUp model = SignUp(
          firstNameProvider.firstName,
          lastNameProvider.lastName,
          emailProvider.email,
          usernameProvider.username,
          passwordProvider.password);
      setState(() {
        passwordRetyped = false;
        isLoading = true;
      });
      Map reply = await Api.signup(model);
      setState(() {
        isLoading = false;
      });
      if (reply['status'] as int == 200) {
        var snackBar = const SnackBar(
          content:
              Text("Successfully signed in. Redirecting you to Login Page.."),
        );
        var featureController =
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
        featureController.closed.then((value) {
          clearFields();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          );
        });
      } else {
        final snackBar = SnackBar(
          content: Text(reply['message'] as String),
        );
        // snackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  clearFields() {
    firstNameProvider.setFirstName('');
    lastNameProvider.setLastName('');
    emailProvider.setEmail('');
    usernameProvider.setUsername('');
    passwordProvider.setPassword('');
  }
}
