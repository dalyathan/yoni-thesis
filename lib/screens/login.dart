import 'package:flutter/material.dart';
import 'package:yoni_thesis/screens/dashboard.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 28.0),
                child: Text(
                  'Amede Birr',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 28.0),
                child: Text(
                  'Make your life simple',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 28.0),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  const Text("Username"),
                  SizedBox(width: size.width * 0.5, child: const TextField())
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  const Text("Password"),
                  SizedBox(width: size.width * 0.5, child: const TextField())
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: SizedBox(
                  width: size.width * 0.25,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))),
                      ),
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Dashboard()),
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(
                            Icons.login,
                            color: Colors.white,
                          ),
                          Text('Login')
                        ],
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
