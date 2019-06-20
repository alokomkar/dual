import 'package:dual_mode/app_state_widget.dart';
import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/ui/chapters/chapters.dart';
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

  //Called from base initstate - always make initializations and data calls here.
  @override
  void initializeData() {
    chaptersMap = Chapter.getAllChapters();
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


  Container _buildListTitle(Chapter chapter) => Container(
    decoration: BoxDecoration(color: Colors.yellow[100]),
    child: new ListTile(
      title: new Text(chapter.moduleTitle, style: buildTextStyleBlack(18),),
      trailing: Icon(Icons.navigate_next),
      onTap: () {
        Navigator.of(context).pushNamed("/chapters_topics");
        //Navigator.of(context).pushNamed("/reorderable_list");
      },
    ),
  );

  _buildParentItem(String chapterTitle, List<Chapter> chaptersList, int position) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(color: Colors.black54),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(chapterTitle, style: buildTextStyle(20),),
            ),
            _buildChildItem(chaptersList),
            Divider(color: Colors.grey, height: 1,),
          ],
        ),
      ),
    );
  }

  _buildChildItem(List<Chapter> chaptersList) {
    debugPrint("Chapters list size ${chaptersList.length}");
    return ListView.builder(itemBuilder: (context, index) {
      return Column(
        children: <Widget>[
          _buildListTitle(chaptersList[index]),
          Divider(color: Colors.black, height: 1,)
        ],
      );
    },
      scrollDirection: Axis.vertical,
      itemCount: chaptersList.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
    );
  }

}