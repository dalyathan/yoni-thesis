import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yoni_thesis/screens/login.dart';
import 'package:yoni_thesis/services/api.dart';
import 'package:yoni_thesis/state/profile.dart';
import 'package:yoni_thesis/state/token.dart';

import '../theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isUploadingPicture = false;
  bool isLoggingOut = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      key: scaffoldKey,
      child: Column(children: [
        Consumer<Profile>(
            builder: (context, value, child) => Stack(
                  children: [
                    SizedBox(
                      width: size.width,
                      height: size.width * 0.7,
                      child: Consumer<Token>(
                          builder: (context, token, child) => Image.network(
                                  Api.makeAbsolute('/profile_image'),
                                  headers: {
                                    "Authorization": "Bearer ${token.token}",
                                    "Access-Control-Allow-Headers":
                                        "Access-Control-Allow-Origin, Accept"
                                  })),
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
                                "${value.account.firstName} ${value.account.lastName}",
                                style: GoogleFonts.sora(
                                    color: MyTheme.lightBlue,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                value.account.email,
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
                            value.account.balance,
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
                    ),
                  ],
                )),
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
              isUploadingPicture
                  ? const SizedBox.square(
                      dimension: 100,
                      child: Center(
                        child: SizedBox.square(
                            dimension: 30, child: CircularProgressIndicator()),
                      ),
                    )
                  : Consumer<Token>(
                      builder: (context, token, child) => ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(54, 80, 111, 1)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28.0),
                              ))),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              withReadStream: true,
                              allowedExtensions: ['jpg', 'png', 'jpeg'],
                            );
                            if (result != null) {
                              setState(() {
                                isUploadingPicture = true;
                              });
                              var reply = await Api.uploadProfilePicture(
                                  result, token.token);
                              setState(() {
                                isUploadingPicture = false;
                              });
                              if (reply['status'] == 413) {
                                toast(
                                    'File size too large, Please select a different file');
                              } else if (reply['status'] == 200) {
                                toast(
                                    'File Uploaded successfully ${reply['message']}');
                              } else if (reply['status'] == -1) {
                                toast(
                                    'Please check your connection and try again');
                              } else {
                                toast(
                                    'Unable to upload file. Please try again later.');
                              }
                            }
                          },
                          child: Column(
                            children: const [
                              Icon(
                                Icons.person_add,
                                size: 100,
                              ),
                              Text("Upload Profile")
                            ],
                          )))
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
              isLoggingOut
                  ? const SizedBox.square(
                      dimension: 100,
                      child: Center(
                        child: SizedBox.square(
                            dimension: 30, child: CircularProgressIndicator()),
                      ),
                    )
                  : Consumer<Token>(
                      builder: (context, token, child) => ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(54, 80, 111, 1)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28.0),
                              ))),
                          onPressed: () async {
                            setState(() {
                              isLoggingOut = true;
                            });
                            await Api.logout(token.token);
                            Navigator.push(
                              scaffoldKey.currentContext!,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                          },
                          child: Column(
                            children: const [
                              Icon(
                                Icons.logout,
                                size: 100,
                              ),
                              Text("Logout")
                            ],
                          )))
            ],
          ),
        )
      ]),
    );
  }

  toast(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    // snackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
