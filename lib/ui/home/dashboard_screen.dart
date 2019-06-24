import 'package:dual_mode/app_state_widget.dart';
import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/ui/chapters/chapters.dart';
import 'package:dual_mode/ui/chapters/simple_topics_arguments.dart';
import 'package:dual_mode/ui/language/language_selection_screen.dart';
import 'package:dual_mode/ui/signup/login_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() {
    return _DashboardScreenState();
  }
}

class _DashboardScreenState extends BaseState<DashboardScreen> {

  Map<String, List<Chapter>> chaptersMap;
  Map<String, String> chaptersSummaryMap;

  //Called from base initstate - always make initializations and data calls here.
  @override
  void initializeData() {
    chaptersMap = Chapter.getAllChapters();
    chaptersSummaryMap = Chapter.getAllChaptersSummary(chaptersMap);
  }

  @override
  Widget build(BuildContext context) => _buildContent();

  Widget _buildContent() {
    userState = AppStateWidget.of(context).userState;
    userPreferences = AppStateWidget.of(context).userPreferences;
    if( userState.user != null ) {
      if( userPreferences.getSelectedLanguage().isEmpty )
        return LanguageSelectionScreen();
      else return _buildBody();
    }
    else
      return LoginScreen();
  }

  Scaffold _buildBody() => Scaffold(
    appBar: buildAppBar("Home"),
    body: _buildChapters(),
  );

  _buildChapters() => ListView.builder(
    itemBuilder: (context, position){
      String chapterTitle = chaptersMap.keys.elementAt(position);
      List<Chapter> chaptersList = chaptersMap[chapterTitle];
      return _buildParentItem(chapterTitle, chaptersList, position);
    },
    itemCount: chaptersMap.length,
  );

  _buildParentItem(String chapterTitle, List<Chapter> chaptersList, int position) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //margin: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Text(chapterTitle.substring(0, 1).toUpperCase(), style: buildTextStyle(24),),
            radius: 30,
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue[900],
          ),
          contentPadding: EdgeInsets.all(2),
          title : Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(chapterTitle, style: buildTextStyleBlack(20)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(chaptersSummaryMap[chapterTitle], style: buildTextStyleBlack(16)),
                    ),
                    LinearProgressIndicator(value: 30,)
                  ],
                ),
              )
          ),
          onTap: () {
            //Navigator.of(context).pushNamed("/chapters_topics", arguments: SimpleTopicsArguments(chaptersList));
            Navigator.of(context).pushNamed("/drag_and_drop", arguments: SimpleTopicsArguments(chaptersList));
            },
        ),
      ),
    );
  }



}