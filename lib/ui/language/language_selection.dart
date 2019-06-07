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

  List<CodeLanguage> codeLanguages = List();

  Widget _makeBody() => Container(
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: codeLanguages.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(codeLanguages[index]);
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    userState = AppStateWidget.of(context).userState;
    dbReference = dbConnection.read();
    return _buildContent();
  }

  Widget _buildContent() {
    _loadLanguages();
    return Scaffold(body: Stack(
      children: <Widget>[
        _buildBody()
      ],
    ));
  }

  onError(Exception e) {
    debugPrint("Error");
  }

  final topAppBar = AppBar(
    elevation: 0.1,
    backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
    title: Text("Select Language"),
  );

  _buildBody() {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: topAppBar,
        body : _makeBody()
    );
  }


  void _loadLanguages() {
    //toggleProgressBar(true);
    dbReference.once().then((snapshot) {
      codeLanguages = CodeLanguage.parseData(snapshot);
      //toggleProgressBar(false);
      setState((){
        codeLanguages = codeLanguages;
      });

    });
  }

  Card makeCard(CodeLanguage language) => Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
      child: _makeListTile(language),
    ),
  );

  ListTile _makeListTile(CodeLanguage language) => ListTile(
    contentPadding:
    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      decoration: new BoxDecoration(
          border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.white24))),
      child: Icon(Icons.language, color: Colors.white),
    ),
    title: Text(
      language.language,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    subtitle: Padding(
        padding: EdgeInsets.only(top: 8),
        child: Text(language.description,
            style: TextStyle(color: Colors.white))),
    trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
    onTap : () {
      userPreferences.setSelectedLanguage(language.language);
      Navigator.of(context).pushReplacementNamed("/");
    }
  );



}