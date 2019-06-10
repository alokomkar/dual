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
  );


  FloatingActionButton _buildFab() => FloatingActionButton(
    onPressed: () {
      if( _currentIndex < _simpleContentList.length - 1 ) {
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
      key: Key("_simple_content_list"),
      itemCount: _displayList.length,
      itemBuilder: (context, position) {
        return _buildItemView( _displayList[position] );
      }
  );

  _buildItemView(SimpleContent displayList) => Container(
      padding: displayList.contentType == SimpleContent.image ? const EdgeInsets.all(0) : const EdgeInsets.all(12),
      margin: displayList.contentType == SimpleContent.image ? EdgeInsets.fromLTRB(0, 8, 0, 8) : EdgeInsets.fromLTRB(0, 8, 32, 8),
      decoration: BoxDecoration(color: Colors.blueAccent),
      child : displayList.contentType == SimpleContent.image ?
      Image.network(
          displayList.contentString)
          :
      Text(
          displayList.contentString,
          style: buildTextSimpleContent(20))
  );




}