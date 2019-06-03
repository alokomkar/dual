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
          /*actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new LoginButton(
                buttonColor: Colors.green,
                buttonText : " Done ",
                onClick: () =>  Navigator.of(context).pop()
            ),
            new LoginButton(
                buttonColor: Colors.redAccent,
                buttonText : "Cancel",
                onClick: () =>  Navigator.of(context).pop()),
          ],*/
        );
      },
    );
  }

  _initAnonSignIn() {
    _printLog("Tour");
    toggleProgressBar(true);
    AppStateWidget.of(context).appHandleAnonUser(isLoading);
  }

  String validatePassword(String value) {
    if (value.trim().isEmpty)
      return 'Password cannot be empty';
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Incorrect email';
    else
      return null;
  }

  _buildContainer() {

    TextEditingController _textFieldEmailController = TextEditingController();
    TextEditingController _textFieldPasswordController = TextEditingController();

    return new Container(
    width: 350,
    child : Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment : CrossAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          controller: _textFieldEmailController,
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
          onSaved: (String val) {
            _email = val;
          },
          decoration: InputDecoration(hintText: "Email"),
        ),
        TextFormField(
          controller: _textFieldPasswordController,
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
            onClick: () =>  _validateEmailPassword()
        ),
        SizedBox(height: 8),
        new LoginButton(
            buttonColor: Colors.redAccent,
            buttonText : "Cancel",
            onClick: () =>  Navigator.of(context).pop()),
      ],
    ),);
  }

  _validateEmailPassword() {
    if( _key.currentState.validate() ) {
      AppStateWidget.of(context).appHandleEmailSignIn(isLoading, _email, _password);
    }
    else {
      setState((){
        _validate = true;
      });
      _validate = false;
    }
  }

}

