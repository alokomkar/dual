import 'package:dual_mode/widgets/LoginButton.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {

  BoxDecoration _buildBackground() {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/splash_logo.png"),
        fit: BoxFit.contain,
      ),
    );
  }

  Container _buildBody() {
    return Container(
      decoration: _buildBackground(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            LoginButton( buttonColor: Colors.redAccent, buttonText : "Sign In with Google", onClick: () => debugPrint("Google")),
            LoginButton( buttonColor: Colors.blue, buttonText : "Sign In with Email", onClick: () => debugPrint("Email")),
            LoginButton( buttonColor: Colors.blueGrey, buttonText : "Take a tour", onClick: () => debugPrint("Tour")),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: _buildBody());

}