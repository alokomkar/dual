import 'dart:async';

import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/ui/simple_content/helper.dart';
import 'package:dual_mode/ui/simple_content/simple_content.dart';
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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  void initializeData() {
    _simpleContentList = getOOFirstContent();
    _displayList.add(_simpleContentList[_currentIndex]);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: buildAppBar("Introduction"),
    body: _buildListView(),
    floatingActionButton: _buildFab(),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  );

  FloatingActionButton _buildFab() => FloatingActionButton(
    onPressed: () {
      if( _currentIndex < _simpleContentList.length - 1 ) {
        Timer(Duration(milliseconds: 750), () => _controller.jumpTo(_controller.position.maxScrollExtent));
        setState(() {
          _listKey.currentState.insertItem(_displayList.length, duration: Duration(milliseconds: 700));
          _displayList.add(_simpleContentList[++_currentIndex]);
        });
      }
    },
    child: Icon(Icons.navigate_next),
    foregroundColor: Colors.white,
    backgroundColor: Colors.blueGrey,
  );

  _buildListView() => AnimatedList(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 72),
      key: _listKey,
      initialItemCount: _displayList.length,
      itemBuilder: (context, position, animation) {
        return _buildAnimatedItemView( _displayList[position], position, animation );
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
        return Container(
          //duration: Duration(milliseconds: _animationDuration),
            padding: const EdgeInsets.all(12),
            margin: EdgeInsets.fromLTRB(0, 8, 32, 8),
            decoration: BoxDecoration(color: Colors.blueAccent),
            child : Text(displayList.contentString, style: buildTextSimpleContent(20, Colors.blueAccent))
        );

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
            PracticeButton(
                buttonColor: Colors.green,
                buttonText : "Practice Now",
                onClick: () => _initPractice(displayList.contentString)),
            Container(
              padding: const EdgeInsets.fromLTRB(36, 8, 48, 8),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
              decoration: BoxDecoration(color: Colors.black),
              child :
              Text(displayList.contentString, textAlign: TextAlign.start, style: buildTextSimpleContent(16, Colors.black)),
            )],
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



}