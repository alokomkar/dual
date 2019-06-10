import 'dart:async';

import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/ui/simple_content/helper.dart';
import 'package:dual_mode/ui/simple_content/simple_content.dart';
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
        Timer(Duration(milliseconds: 50), () => _controller.jumpTo(_controller.position.maxScrollExtent));
        setState(() {
          _displayList.add(_simpleContentList[++_currentIndex]);
        });
      }
    },
    child: Icon(Icons.navigate_next),
    foregroundColor: Colors.white,
    backgroundColor: Colors.blueGrey,
  );

  ListView _buildListView() => ListView.builder(
    padding: EdgeInsets.fromLTRB(0, 0, 0, 72),
      key: Key("_simple_content_list"),
      controller: _controller,
      itemCount: _displayList.length,
      itemBuilder: (context, position) {
        return _buildItemView( _displayList[position] );
      }
  );

  _buildItemView(SimpleContent displayList) {
    switch( displayList.contentType ) {
      case SimpleContent.header :
        return Container(
            padding: const EdgeInsets.all(12),
            margin: EdgeInsets.fromLTRB(0, 8, 32, 8),
            decoration: BoxDecoration(color: Colors.blueAccent),
            child : Text(displayList.contentString, style: buildTextSimpleContent(20, Colors.blueAccent))
        );

      case SimpleContent.content :
        return Container(
            padding: const EdgeInsets.all(12),
            margin: EdgeInsets.fromLTRB(32, 8, 0, 8),
            decoration: BoxDecoration(color: Colors.yellow[100]),
            child : Text(displayList.contentString, style: buildTextSimpleContentBlack(16, Colors.yellow[100]))
        );

      case SimpleContent.bullets :
        return Container(
            padding: const EdgeInsets.all(12),
            margin: EdgeInsets.fromLTRB(0, 8, 32, 8),
            decoration: BoxDecoration(color: Colors.grey[200]),
            child : Text(displayList.contentString, style: buildTextSimpleContentBlack(16, Colors.grey[200]))
        );

      case SimpleContent.code :
        return Container(
            padding: const EdgeInsets.all(12),
            margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
            decoration: BoxDecoration(color: Colors.black),
            child : Text(displayList.contentString, style: buildTextSimpleContent(16, Colors.black))
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
            padding: const EdgeInsets.all(12),
            margin: EdgeInsets.fromLTRB(0, 8, 32, 8),
            decoration: BoxDecoration(color: Colors.blueAccent),
            child : Text(displayList.contentString, style: buildTextSimpleContent(20, Colors.blueAccent))
        );
    }

  }

}