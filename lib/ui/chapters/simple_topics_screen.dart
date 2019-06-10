import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/ui/simple_content/helper.dart';
import 'package:dual_mode/ui/simple_content/simple_content.dart';
import 'package:flutter/material.dart';

class SimpleContentScreen extends StatefulWidget {
  @override
  _SimpleContentScreenState createState() => _SimpleContentScreenState();
}

class _SimpleContentScreenState extends BaseState<SimpleContentScreen> {

  List<SimpleContent> simpleContentList;
  List<SimpleContent> displayList = List();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    simpleContentList = getOOFirstContent();
    displayList.add(simpleContentList[_currentIndex++]);

    return Scaffold(
      appBar: buildAppBar("Introduction"),
      body: _buildListView(),
      floatingActionButton: _buildFab(),
    );
  }

  FloatingActionButton _buildFab() => FloatingActionButton(
    onPressed: () {
      setState(() {
        if( _currentIndex < simpleContentList.length - 2 )
          displayList.add(simpleContentList[_currentIndex++]);
      });
    },
    child: Icon(Icons.navigate_next),
    foregroundColor: Colors.white,
    backgroundColor: Colors.blueGrey,
  );

  ListView _buildListView() => ListView.builder(
      itemCount: displayList.length,
      itemBuilder: (context, position) {
        return _buildItemView( displayList[position] );
      }
  );

  _buildItemView(SimpleContent displayList) => Container(
    padding: const EdgeInsets.all(12),
    margin: EdgeInsets.fromLTRB(0, 8, 32, 0),
    decoration: BoxDecoration(color: Colors.blueAccent),
    child : Row (
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.start,
    children : <Widget>[
      new Text(
          displayList.contentString,
          style: buildTextSimpleContent(20))
      ,
    ],
  )
  );


}