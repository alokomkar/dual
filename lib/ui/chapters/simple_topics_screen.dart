import 'dart:async';

import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/ui/chapters/chapters.dart';
import 'package:dual_mode/ui/chapters/simple_topics_arguments.dart';
import 'package:dual_mode/ui/simple_content/helper.dart';
import 'package:dual_mode/ui/simple_content/simple_content.dart';
import 'package:dual_mode/widgets/blink_button.dart';
import 'package:dual_mode/widgets/header_widget.dart';
import 'package:dual_mode/widgets/practice_button.dart';
import 'package:flutter/material.dart';

class SimpleContentScreen extends StatefulWidget {
  @override
  _SimpleContentScreenState createState() => _SimpleContentScreenState();
}

class _SimpleContentScreenState extends BaseState<SimpleContentScreen> {

  List<SimpleContent> _simpleContentList;
  List<SimpleContent> _displayList = List();
  int _currentIndex = 0;
  ScrollController _controller = ScrollController();
  String title = "";
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  void initializeData() {
    title = "Introduction";
    _simpleContentList = getOOFirstContent();
    _displayList.add(_simpleContentList[_currentIndex]);
  }


  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: buildAppBar(title),
      drawer: _buildDrawer(),
      body: _buildListView(),
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  FloatingActionButton _buildFab() => FloatingActionButton(
    onPressed: () {
      if( _currentIndex < _simpleContentList.length - 1 ) {
        //initializeControllerTextAnimation();
        setState(() {
          _listKey.currentState.insertItem(_displayList.length, duration: Duration(milliseconds: 500));
          _displayList.add(_simpleContentList[++_currentIndex]);
        });
        //_controller.animateTo(_controller.position.maxScrollExtent, duration: Duration(milliseconds: 700), curve: Curves.easeOut);
        //_controller.jumpTo(_controller.position.maxScrollExtent);
        Timer(Duration(milliseconds: 520), () => _controller.jumpTo(_controller.position.maxScrollExtent));
      }
    },
    child: Icon(Icons.navigate_next),
    foregroundColor: Colors.white,
    backgroundColor: Colors.blueGrey,
  );

  _buildListView() => AnimatedList(
      controller: _controller,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 72),
      key: _listKey,
      initialItemCount: _displayList.length,
      itemBuilder: (context, position, animation) {
        return _buildAnimatedItemView( _displayList[position], position, animation ); /*SlideTransition(
          position: animation.drive(Tween(begin: Offset(200, 0.0), end: Offset.zero)),
          child: _buildItemView(_displayList[position])*//*_buildAnimatedItemView( _displayList[position], position, animation )*//*,
        );*/
      }
  );

  _buildAnimatedItemView(SimpleContent displayList, int position, Animation<double> animation) => SizeTransition(
    key: ValueKey(position),
    axis: Axis.vertical,
    sizeFactor: animation,
    child: _buildItemView(displayList),
  );

  _buildItemView(SimpleContent displayList) {
    switch( displayList.contentType ) {
      case SimpleContent.header :
        return HeaderWidget(displayList);

      case SimpleContent.content :
        return Container(
          //duration: Duration(milliseconds: _animationDuration),
            padding: const EdgeInsets.all(12),
            margin: EdgeInsets.fromLTRB(32, 8, 0, 8),
            decoration: BoxDecoration(color: Colors.yellow[100]),
            child : Text(displayList.contentString, style: buildTextSimpleContentBlack(16, Colors.yellow[100]))
        );

      case SimpleContent.bullets :
        return Container(
          //duration: Duration(milliseconds: _animationDuration),
            padding: const EdgeInsets.all(12),
            margin: EdgeInsets.fromLTRB(0, 8, 32, 8),
            decoration: BoxDecoration(color: Colors.grey[200]),
            child : Text(displayList.contentString, style: buildTextSimpleContentBlack(16, Colors.grey[200]))
        );

      case SimpleContent.code :
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 12,),
            SizedBox(
              height: 44,
              width: 130,
              child: PracticeButton(
                  buttonColor: Colors.green,
                  buttonText : "Practice Now",
                  onClick: () => _initPractice(displayList.contentString)) ,
            ),
            buildCodeBlock(displayList.contentString, 14)
          ],
        );

      case SimpleContent.image :
        return Container(
            padding:  const EdgeInsets.all(0),
            margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
            decoration: BoxDecoration(color: Colors.grey),
            child : FadeInImage(
                placeholder: AssetImage('assets/splash_logo.png'),
                image: NetworkImage(displayList.contentString)
            )
        );

      case SimpleContent.mcq :
        return _buildQuestionContainer(Colors.red, "Multi choice", "/multi_choice");

      case SimpleContent.codeMcq :
        return _buildQuestionContainer( Colors.cyan, "Code Quiz", "/multi_choice_code");

      case SimpleContent.drag_and_drop :
        return _buildQuestionContainer( Colors.black54, "Fill blanks", "/drag_and_drop");

      case SimpleContent.syntaxLearn :
        return _buildQuestionContainer( Colors.blueGrey, "Learn syntax", "/syntax_learn");

      default :
        return Container(
          //duration: Duration(milliseconds: _animationDuration),
            padding: const EdgeInsets.all(12),
            margin: EdgeInsets.fromLTRB(0, 8, 32, 8),
            decoration: BoxDecoration(color: Colors.blueAccent),
            child : Text(displayList.contentString, style: buildTextSimpleContent(20, Colors.blueAccent))
        );
    }

  }

  _initPractice(String contentString) {
    Navigator.of(context).pushNamed("/reorderable_list");
  }

  _buildDrawer() => Drawer(
    child: _buildSubTopicsListView(),
  );

  _buildSubTopicsListView() {
    final SimpleTopicsArguments simpleTopicsArguments = ModalRoute.of(context).settings.arguments;
    final List<Chapter> chapterList = simpleTopicsArguments.chaptersList;
    return ListView(
      scrollDirection: Axis.vertical,
      children: chapterList.map<Widget>(_buildSubTopicView).toList(),
    );
  }

  Widget _buildSubTopicView(Chapter chapter) => Container(
    key: Key(chapter.moduleTitle.toString()),
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1))
    ),
    child: ListTile(
      title: Text(
        chapter.moduleTitle,
        style: TextStyle(
            fontFamily: 'VarelaRound-Regular',
            fontSize: 17,
            color: Colors.black,
            backgroundColor: Colors.white
        ),),
      onTap: (){
        Navigator.pop(context);
        setState(() {
          title = chapter.moduleTitle;
        });
      },
    ),

  );

  _buildQuestionContainer( Color color, String title, String path ) => BlinkButton(color, path);




}