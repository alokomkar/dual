import 'package:dual_mode/app_state_widget.dart';
import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/base/routes.dart';
import 'package:dual_mode/ui/chapters/chapters.dart';
import 'package:dual_mode/ui/language/language_selection_screen.dart';
import 'package:dual_mode/ui/signup/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends BaseState<HomeScreen> {
  //Called from base initstate - always make initializations and data calls here.
  @override
  void initializeData() {
    chaptersMap = Chapter.getAllChapters();
  }

  Map<String, List<Chapter>> chaptersMap;

  @override
  Widget build(BuildContext context) => _buildContent();

  Widget _buildContent() {
    userState = AppStateWidget.of(context).userState;
    userPreferences = AppStateWidget.of(context).userPreferences;
    if (userState.user != null) {
      if (userPreferences.getSelectedLanguage().isEmpty)
        return LanguageSelectionScreen();
      else
        return _buildBody();
    } else
      return LoginScreen();
  }

  Scaffold _buildBody() {
    return Scaffold(
        appBar: buildAppBar("Home"), body: Center(child: _buildListView()));
  }

  ListView _buildListView() => ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: chaptersMap.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, position) {
        String chapterTitle = chaptersMap.keys.elementAt(position);
        List<Chapter> chaptersList = chaptersMap[chapterTitle];
        Color colorCode = position % 2 == 0 ? Colors.grey : Colors.blueGrey;
        return _makeCard(colorCode, chapterTitle, chaptersList);
      });

  Card _makeCard(
          Color colorCode, String chapterTitle, List<Chapter> chaptersList) =>
      Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: colorCode),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: _makeExpansionTile(chapterTitle, chaptersList),
          ),
        ),
      );

  ExpansionTile _makeExpansionTile(
          String chapterTitle, List<Chapter> chaptersList) =>
      ExpansionTile(
        title: Text(
          chapterTitle,
          style: buildTextStyle(24),
        ),
        children: <Widget>[
          Column(
            children: _buildExpandableContent(chaptersList),
          )
        ],
      );

  _buildExpandableContent(List<Chapter> chaptersList) {
    List<Widget> columnContent = [];

    for (Chapter content in chaptersList)
      columnContent.add(
        Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            padding: EdgeInsets.all(10),
            child: new ListTile(
              title: new Text(
                content.moduleTitle,
                style: buildTextStyleBlack(20),
              ),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pushNamed(SimpleContentScreenRoute);
              },
            ),
          ),
        ),
      );

    return columnContent;
  }
}
