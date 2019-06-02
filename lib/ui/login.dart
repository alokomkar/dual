import 'package:dual_mode/app_state_widget.dart';
import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/widgets/LoginButton.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LoginState();
}

class LoginState extends BaseState<LoginScreen> {

  //_function indicates private function.
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
            LoginButton( buttonColor: Colors.redAccent, buttonText : "Sign In with Google", onClick: () => _initGoogleSignIn()),
            LoginButton( buttonColor: Colors.blue, buttonText : "Sign In with Email", onClick: () => _initEmailSignIn()),
            LoginButton( buttonColor: Colors.blueGrey, buttonText : "Take a tour", onClick: () => _initAnonSignIn()),
          ],
        ),
      ),
    );
  }

  _initGoogleSignIn() {
    toggleProgressBar(true);
    AppStateWidget.of(context).appHandleGoogleSignIn(isLoading);
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

  _showSnackBar( String message ) => debugPrint(message);

  _initEmailSignIn() {
    _showSnackBar("Email");
    toggleProgressBar(true);
    AppStateWidget.of(context).appHandleEmailSignIn(isLoading, "", "");
  }

  _initAnonSignIn() {
    _showSnackBar("Tour");
    toggleProgressBar(true);
    AppStateWidget.of(context).appHandleEmailSignUp(isLoading, "", "");
  }

}

