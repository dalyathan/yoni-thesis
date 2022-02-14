import 'package:flutter/material.dart';
import '/screens/item_list.dart';
import '/screens/scanner.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Dashboard'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: profile(size),
            ),
            Action('Scan and Buy', const QRViewExample(), size),
            SizedBox(
              height: size.height * 0.1,
            ),
            //Action('Item List', const ItemList(), size)
          ],
        ),
      ),
    );
  }

  Widget profile(Size size) {
    return Row(
      children: [
        SizedBox(
          width: size.width * 0.2,
          height: size.width * 0.2,
          child: CircleAvatar(
            child: Image.asset('assets/images/apple.jpg'),
          ),
        ),
        SizedBox(
          width: size.width * 0.1,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [Text('Surafel Melese'), Text('\$89.00')],
        )
      ],
    );
  }

  Widget Action(String title, Widget onPressedgoto, Size size) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: SizedBox(
          width: size.width * 0.75,
          height: size.height * 0.1,
          child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
              ),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => onPressedgoto),
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                  Text(
                    title,
                    style: TextStyle(fontSize: 25),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
