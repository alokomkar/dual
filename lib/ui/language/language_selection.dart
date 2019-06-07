import 'package:dual_mode/app_state_widget.dart';
import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/database/firebase_realtime_db_util.dart';
import 'package:dual_mode/ui/language/code_language.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LanguageSelectionState();
}

class LanguageSelectionState extends BaseState<LanguageSelectionScreen> {

  FirebaseDBCrudForCodeLanguage dbConnection = FirebaseDBCrudForCodeLanguage();
  Query dbReference;
  String languages = "";

  List<CodeLanguage> codeLanguages;

  @override
  Widget build(BuildContext context) {
    userState = AppStateWidget.of(context).userState;
    dbReference = dbConnection.read();
    return _buildContent();
  }

  Widget _buildContent() {
    toggleProgressBar(true);
    dbReference.once().then((snapshot) {
      codeLanguages = CodeLanguage.parseData(snapshot);
      languages = "";
      for( CodeLanguage code in codeLanguages ) {
        languages += code.toString() + "\n\n";
      }
      setState((){
        languages = languages;
      });

    });
    return new Scaffold(
        body : new Center( child : new Text(languages, textAlign: TextAlign.center,),));
  }


  onError(Exception e) {
    debugPrint("Error");
  }

}