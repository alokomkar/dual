import 'package:dual_mode/base/base_preferences.dart';
import 'package:dual_mode/model/user_state.dart';
import 'package:dual_mode/widgets/syntax_highlighter.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {

  bool isLoading = false;
  UserState userState;
  UserPreferences userPreferences;
  SyntaxHighlighterStyle _style = SyntaxHighlighterStyle.darkThemeStyle();

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

  buildCodeBlock( String code, double fontSize ) => SizedBox(
    width: double.infinity,
    child : Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.black),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontFamily: 'VarelaRound-Regular', fontSize: fontSize),
          children: <TextSpan>[
            DartSyntaxHighlighter(_style).format(code)
          ],
        ),
      ),
    ),
  );

  void showSnackBar(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new
  GlobalKey<ScaffoldState>();


  buildBottomSheet(bool isCorrect, String message, String solution) {
    showModalBottomSheet(context: context, builder: (BuildContext builderContext) {
      return Container(
        key: _scaffoldKey,
        color: Colors.black54,
        padding: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              color: Colors.black,
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(message, style: TextStyle(
                    fontFamily: 'VarelaRound-Regular',
                    fontSize: 16,
                    color:  isCorrect ? Colors.green : Colors.red,
                  ),
                  ),
                  Text("The solution is :\n" + solution, style: buildTextStyle(16),
                  ),
                ],
              )),
        ),

      );
    });
  }

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData();

}