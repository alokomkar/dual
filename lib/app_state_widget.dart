import 'package:dual_mode/base/base_preferences.dart';
import 'package:dual_mode/ui/signup/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dual_mode/auth/auth.dart';
import 'model/user_state.dart';

class AppStateWidget extends StatefulWidget {
  final UserState state;
  final Widget child;

  AppStateWidget({
    @required this.child,
    this.state,
  });

  // Returns data of the nearest widget _StateDataWidget
  // in the widget tree.
  static _AppStateWidgetState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_AppStateDataWidget)
    as _AppStateDataWidget)
        .data;
  }

  @override
  _AppStateWidgetState createState() => new _AppStateWidgetState();

}

class _AppStateWidgetState extends State<AppStateWidget> {

  UserState userState;
  UserPreferences userPreferences = UserPreferences();

  @override
  void initState() {
    super.initState();
    if (widget.state != null) {
      userState = widget.state;
    } else {
      userState = new UserState();
      initUser();
    }
  }

  @override
  Widget build(BuildContext context) => _AppStateDataWidget(data : this, child : widget.child);

  void initUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      userState.user = user;
      debugPrint("App State Widget : User status : " + userState.user.toString());
    });
  }

  Future<Null> appHandleGoogleSignIn(FirebaseSuccessListener listener) async {
    handleSignIn()
        .then((FirebaseUser user) {
      setState(() {
        userState.user = user;
      });
      listener.onSuccess(user);
    }).catchError((e) {
      debugPrint("Error sigining in " + e.toString());
      listener.onFirebaseError(e.toString());
    });
  }

  Future<Null> appHandleEmailSignIn( String email, String password, FirebaseSuccessListener listener) async {
    handleEmailSignIn(email, password)
        .then((FirebaseUser user) {
      setState(() {
        userState.user = user;
      });
      listener.onSuccess(user);
    }).catchError((e) {
      debugPrint("Error sigining in " + e.toString());
      appHandleEmailSignUp(true, email, password, listener);
    });
  }

  Future<Null> appHandleEmailSignUp(bool isLoading, String email, String password, FirebaseSuccessListener listener) async {
    handleEmailSignUp(email, password)
        .then((FirebaseUser user) {
      isLoading = false;
      setState(() {
        userState.user = user;
      });
      listener.onSuccess(user);
    }).catchError((e) {
      debugPrint("Error sigining in " + e.toString());
      isLoading = false;
      listener.onFirebaseError(e.toString());
    });
  }

  void appHandleAnonUser( FirebaseSuccessListener listener) {
    handleAnonUser()
        .then((FirebaseUser user) {
      setState(() {
        userState.user = user;
      });
      listener.onSuccess(user);
    }).catchError((e) {
      debugPrint("Error sigining in " + e.toString());
      listener.onFirebaseError(e.toString());
    });
  }

}

class _AppStateDataWidget extends InheritedWidget {

  final _AppStateWidgetState data;

  _AppStateDataWidget({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  // Rebuild the widgets that inherit from this widget
  // on every rebuild of _StateDataWidget:
  @override
  bool updateShouldNotify(_AppStateDataWidget old) => true;

}