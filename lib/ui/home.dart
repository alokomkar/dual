import 'package:dual_mode/app_state_widget.dart';
import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/ui/chapters/chapters.dart';
import 'package:dual_mode/ui/language/language_selection.dart';
import 'package:dual_mode/ui/login.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends BaseState<HomeScreen> {

  Map<String, List<Chapter>> chaptersMap;

  @override
  Widget build(BuildContext context) {
    chaptersMap = Chapter.getAllChapters();
    userState = AppStateWidget.of(context).userState;
    userPreferences = AppStateWidget.of(context).userPreferences;
    return _buildContent();
  }

  AppBar _buildAppBar() => AppBar(
    elevation: 0.1,
    backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
    title: Text("Home",
    style: _buildTextStyle(22),),
  );

  Widget _buildContent() {
    if( userState.user != null ) {
      if( userPreferences.getSelectedLanguage().isEmpty )
        return LanguageSelectionScreen();
      else return _buildBody();
    }
    else
      return LoginScreen();
  }

  Scaffold _buildBody() {
    return Scaffold(
        appBar: _buildAppBar(),
        body : Center( child : _buildListView()));
  }

  ListView _buildListView() => ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: chaptersMap.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, position) {
        String key = chaptersMap.keys.elementAt(position);
        List<Chapter> chaptersList = chaptersMap[key];
        Color colorCode = position % 2 == 0 ? Colors.grey : Colors.blueGrey;
        return _makeCard(colorCode, key, chaptersList);
      });

  Card _makeCard(Color colorCode, String key, List<Chapter> chaptersList) => Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: colorCode),
      child: _makeExpansionTile(key, chaptersList),
    ),
  );

  ExpansionTile _makeExpansionTile(String key, List<Chapter> chaptersList) => ExpansionTile(
      title: Text(
        key,
        style:  _buildTextStyle(24),
      ),
      children: <Widget>[
        Column(
          children: _buildExpandableContent(chaptersList),
        )
      ],

  );

  TextStyle _buildTextStyle( double fontSize ) {
    return TextStyle(
        fontFamily: 'VarelaRound-Regular',
        fontSize: fontSize,
        color: Colors.white,
      );
  }

  _buildExpandableContent(List<Chapter> chaptersList) {
    List<Widget> columnContent = [];

    for (Chapter content in chaptersList)
      columnContent.add(
        new ListTile(
          title: new Text(content.moduleTitle, style: _buildTextStyle(20),),
          trailing: new Icon(Icons.arrow_right),
          onTap: () {

          },
        ),
      );

    return columnContent;
  }

}