import 'package:dual_mode/app_state_widget.dart';
import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/widgets/login_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LoginState();
}

abstract class FirebaseSuccessListener {
  void onSuccess( FirebaseUser  user );
  void onFirebaseError( String error );
}

class LoginState extends BaseState<LoginScreen> with SingleTickerProviderStateMixin implements FirebaseSuccessListener {

  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initializeData() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 200).animate(_animationController);
    _animation.addListener(() {
      setState(() {

      });
    });
    _animationController.forward();
  }

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
    AppStateWidget.of(context).appHandleGoogleSignIn(this);
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    userState = AppStateWidget.of(context).userState;
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            _buildBody(),
            buildProgressBar()
          ],
        ));
  }

  _printLog( String message ) => debugPrint(message);

  _initEmailSignIn() {
    _printLog("Email");
    _showDialog();
    //toggleProgressBar(true);
    //AppStateWidget.of(context).appHandleEmailSignIn(isLoading, "", "");
  }

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  String _email;
  String _password;
  // user defined function
  void _showDialog() {

    resetState();
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Email Signup / Login"),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Form(
            key: _key,
            child: _buildContainer(),
            autovalidate: _validate,
          ),
        );
      },
    );
  }

  _initAnonSignIn() {
    _printLog("Tour");
    toggleProgressBar(true);
    AppStateWidget.of(context).appHandleAnonUser(this);
  }

  String validatePassword(String value) {
    if (value.trim().isEmpty)
      return 'Password cannot be empty';
    else {
      _password = value;
      return null;
    }

  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Incorrect email';
    else {
      _email = value;
      return null;
    }

  }

  _buildContainer() {

    return new Container(
      width: 350,
      child : Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment : CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
            onSaved: (String val) {
              _email = val;
            },
            decoration: InputDecoration(hintText: "Email"),
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            obscureText: true,
            validator: validatePassword,
            onSaved: (String val) {
              _password = val;
            },
            decoration: InputDecoration(hintText: "Password"),
          ),
          SizedBox(height: 16),
          new LoginButton(
              buttonColor: Colors.green,
              buttonText : "Done",
              onClick: () =>  _validateEmailPassword() //_showSnackBar("TODO Email Password Validation")//_validateEmailPassword()
          ),
          SizedBox(height: 8),
          new LoginButton(
              buttonColor: Colors.redAccent,
              buttonText : "Cancel",
              onClick: () =>  Navigator.of(context).pop()),
        ],
      ),);
  }

  _showSnackBar( String message ) => _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));

  _validateEmailPassword() {
    if( _key.currentState.validate() ) {
      Navigator.of(context).pop();
      toggleProgressBar(true);
      AppStateWidget.of(context).appHandleEmailSignIn( _email, _password, this);
    }
    else {
      setState((){
        _validate = true;
      });
    }
  }

  void resetState() {
    setState(() {
      _validate = false;
    });
  }

  @override
  void onFirebaseError(String error) {
    toggleProgressBar(false);
    _showSnackBar(error);
  }

  @override
  void onSuccess(FirebaseUser user) {
    toggleProgressBar(false);
  }



}

