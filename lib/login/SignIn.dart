import 'package:flutter/material.dart';
import '../Screens/Landing_screen.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Landing.routeName);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10)),
        alignment: AlignmentDirectional.center,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(25),
        child: const Text("Sign in",
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }
}
