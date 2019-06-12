import 'package:dual_mode/base/base_preferences.dart';
import 'package:dual_mode/model/user_state.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {

  bool isLoading = false;
  UserState userState;
  UserPreferences userPreferences;

  toggleProgressBar( bool isVisible ) {
    setState(() {
      isLoading = isVisible;
    });
  }

  AppBar buildAppBar( String title ) => AppBar(
    elevation: 0.1,
    backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
    title: Text(title,
      style: buildTextStyle(22),),
  );

  buildProgressBar() =>
      isLoading ?
      Center(child: CircularProgressIndicator())
          :
      Container(height: 0.0, width: 0.0,);

  TextStyle buildTextStyleBlack( double fontSize ) {
    return TextStyle(
      fontFamily: 'VarelaRound-Regular',
      fontSize: fontSize,
      color: Colors.black,
    );
  }

  TextStyle buildTextSimpleContent( double fontSize, Color color ) {
    return TextStyle(
      fontFamily: 'VarelaRound-Regular',
      fontSize: fontSize,
      backgroundColor: color,
      color: Colors.white,
    );
  }

  TextStyle buildTextSimpleContentBlack( double fontSize, Color color ) {
    return TextStyle(
      fontFamily: 'VarelaRound-Regular',
      fontSize: fontSize,
      backgroundColor: color,
      color: Colors.black,
    );
  }

  TextStyle buildTextStyle( double fontSize ) {
    return TextStyle(
      fontFamily: 'VarelaRound-Regular',
      fontSize: fontSize,
      color: Colors.white,
    );
  }

  void showSnackBar(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData();

}