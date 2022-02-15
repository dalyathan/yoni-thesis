import '../theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginFormHead extends StatelessWidget {
  final double height;
  const LoginFormHead({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        height: height,
        width: size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.5,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      "Vending Machine",
                      style: GoogleFonts.sora(
                          color: MyTheme.lightBlue,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.4,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  "Enter your username and password",
                  style: GoogleFonts.sora(color: Colors.black, fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
