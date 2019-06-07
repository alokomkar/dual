import 'package:dual_mode/app_state_widget.dart';
import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/ui/language/language_selection.dart';
import 'package:dual_mode/ui/login.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends BaseState<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    userState = AppStateWidget.of(context).userState;
    return _buildContent();
  }

  Widget _buildContent() {
    if( userState.user != null ) {
      if( userPreferences.getSelectedLanguage().isEmpty ) {
        return new LanguageSelectionScreen();
      }
      else return new Scaffold(
          body : new Center( child : new Text("Coding here", textAlign: TextAlign.center,),));
    }
    else
      return new LoginScreen();
  }

}