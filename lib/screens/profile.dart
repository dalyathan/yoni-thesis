import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(children: [
        Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.width * 0.7,
              child: CachedNetworkImage(imageUrl: 'https://bit.ly/3gHB66d'),
            ),
            Container(
              width: size.width,
              height: size.width * 0.7,
              color: Colors.black26,
              child: Row(children: [
                Align(
                  alignment: const Alignment(-0.9, 0.9),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Yonas Fisseha",
                        style: GoogleFonts.sora(
                            color: MyTheme.lightBlue,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "0987654321",
                        style: GoogleFonts.sora(
                            color: MyTheme.darkBlue,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const Spacer(
                  flex: 4,
                ),
                Align(
                  alignment: const Alignment(0.4, 0.8),
                  child: Text(
                    "100.00 Birr",
                    style: GoogleFonts.sora(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
              ]),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1, vertical: size.height * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(54, 80, 111, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                      ))),
                  onPressed: () {},
                  child: Column(
                    children: const [
                      Icon(
                        Icons.monetization_on,
                        size: 100,
                      ),
                      Text("Recharge Balance")
                    ],
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(54, 80, 111, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                      ))),
                  onPressed: () {},
                  child: Column(
                    children: const [
                      Icon(
                        Icons.person_add,
                        size: 100,
                      ),
                      Text("Update Profile")
                    ],
                  ))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1, vertical: size.height * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(54, 80, 111, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                      ))),
                  onPressed: () {},
                  child: Column(
                    children: const [
                      Icon(
                        Icons.sell,
                        size: 100,
                      ),
                      Text("Records")
                    ],
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(54, 80, 111, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                      ))),
                  onPressed: () => Navigator.pop(context),
                  child: Column(
                    children: const [
                      Icon(
                        Icons.logout,
                        size: 100,
                      ),
                      Text("Logout")
                    ],
                  ))
            ],
          ),
        )
      ]),
    );
  }
}
