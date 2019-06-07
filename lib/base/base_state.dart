import 'package:dual_mode/base/prefs.dart';
import 'package:dual_mode/model/user_state.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {

  bool isLoading = false;
  UserState userState;
  UserPreferences userPreferences = UserPreferences();

  toggleProgressBar( bool isVisible ) {
    setState(() {
      isLoading = isVisible;
    });
  }

  buildProgressBar() =>
      isLoading ?
      Center(child: CircularProgressIndicator())
          :
      Container(height: 0.0, width: 0.0,);

}