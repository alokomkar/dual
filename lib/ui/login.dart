import 'package:dual_mode/app_state_widget.dart';
import 'package:dual_mode/auth/auth.dart';
import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/widgets/LoginButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LoginState();
}

class LoginState extends BaseState<LoginScreen> {

  _buildBackground() => BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/splash_logo.png"),
      fit: BoxFit.none,
    ),
  );

  Container _buildBody() {
    return Container(
      decoration: _buildBackground(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            LoginButton( buttonColor: Colors.redAccent, buttonText : "Sign In with Google", onClick: () => initGoogleSignIn()),
            LoginButton( buttonColor: Colors.blue, buttonText : "Sign In with Email", onClick: () => debugPrint("Email")),
            LoginButton( buttonColor: Colors.blueGrey, buttonText : "Take a tour", onClick: () => debugPrint("Tour")),
          ],
        ),
      ),
    );
  }

  initGoogleSignIn() {
    toggleProgressBar(true);
    handleSignIn()
        .then((FirebaseUser user) {
          toggleProgressBar(false);
          setState(() {
            userState.user = user;
          });
    }).catchError((e) {
      _showSnackBar(e.toString());
      toggleProgressBar(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    userState = AppStateWidget.of(context).userState;
    return Scaffold(body: Stack(
      children: <Widget>[
        _buildBody(),
        buildProgressBar()
      ],
    ));
  }

  _showSnackBar( String message ) => SnackBar( content: Text(message));

}

