import 'package:dual_mode/widgets/LoginButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LoginState();
}

class LoginState extends State<LoginScreen> {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
  }

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

  _toggleProgressBar( bool isVisible ) {
    setState(() {
      isLoading = isVisible;
    });
  }

  initGoogleSignIn() {
    _toggleProgressBar(true);
    _handleSignIn(_googleSignIn, _auth)
        .then((FirebaseUser user) {

      navigateToHome();
    })
        .catchError((e) {
      _showSnackBar(e.toString());
      _toggleProgressBar(false);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: Stack(
    children: <Widget>[
      _buildBody(),
      _buildProgressBar()
    ],
  ));

  _buildProgressBar() =>
      isLoading ?
      Center(child: CircularProgressIndicator())
          :
      Container(height: 0.0, width: 0.0,);

  Future<FirebaseUser> _handleSignIn(GoogleSignIn _googleSignIn, FirebaseAuth _auth) async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    return user;
  }

  _showSnackBar( String message ) => SnackBar( content: Text(message));

  void navigateToHome() {
    _toggleProgressBar(false);
    Navigator.pushNamed(context, "/home");
  }

}

