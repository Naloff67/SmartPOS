import 'package:flutter/material.dart';
import 'Textfield.dart';
import './SignIn.dart';
import './login_dummy.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/LoginPage';

  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  void UsersignIn() {
    return null;
  }

  final boxsize = (number) {
    return SizedBox(
      height: number,
    );
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Welcome to SmartPOS System",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MytextField(
                    controller: usernameController,
                    hintText: "Username",
                    obscureText: false,
                  ),
                  MytextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SignIn(),
                ],
              ),
            ),
          ),
        ));
  }
}
