import 'package:dual_mode/base/base_state.dart';
import 'package:flutter/material.dart';

class RearrangeCodeScreen extends StatefulWidget {
  @override
  _RearrangeCodeScreenState createState() {
    return _RearrangeCodeScreenState();
  }
}

class _ListItem {
  _ListItem(this.id, this.value, this.checkState);
  final int id;
  final String value;
  bool checkState;
}

class _RearrangeCodeScreenState extends BaseState<RearrangeCodeScreen> {

  List<_ListItem> _originalList = List();
  List<_ListItem> _modifiedList = List();
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: buildAppBar("Reorder"),
    body: _buildListView(),
    floatingActionButton: _buildFab(),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  );

  _buildListView() => !_isChecked ? ReorderableListView(
    onReorder: _onReorder,
    children: _modifiedList.map<Widget>(_buildListTitle).toList(),
  )
      : ListView(
    scrollDirection: Axis.vertical,
    children: _modifiedList.map<Widget>(_buildListTitle).toList(),
  );

  _buildFab() => FloatingActionButton(
    onPressed: () {
      setState(() {
        int index = 0;
        _modifiedList.forEach((_ListItem item) {
          item.checkState = item.value == _originalList[index++].value;
        });
        _isChecked = true;
      });
    },
    child: Icon(Icons.check),
    foregroundColor: Colors.white,
    backgroundColor: Colors.green,
  );

  @override
  void initializeData() {

    //Generating unique id to ensure key is always unique. - don't remove this

    int id = 0;
    _originalList.add(_ListItem(id++, "class HelloWorld {", false));
    _originalList.add(_ListItem(id++, "public static void main( String args[] ) {", false));
    _originalList.add(_ListItem(id++, "System.out.println(\"Hello World\");", false));
    _originalList.add(_ListItem(id++, "}", false));
    _originalList.add(_ListItem(id++, "}", false));

    _modifiedList.addAll(_originalList);
    _modifiedList.shuffle();
  }

  void _onReorder(int oldIndex, int newIndex) {
    if( !_isChecked ) {
      setState(() {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final _ListItem item = _modifiedList.removeAt(oldIndex);
        _modifiedList.insert(newIndex, item);
      });
    }
  }

  Widget _buildListTitle(_ListItem code) => Container(
    key: Key(code.id.toString()),
    decoration: BoxDecoration(color: !_isChecked ? Colors.white : code.checkState ? Colors.green : Colors.red),
    child: ListTile(
      title: Text(
        code.value,
        style: TextStyle(
            fontFamily: 'VarelaRound-Regular',
            fontSize: 18,
            color: !_isChecked ? Colors.black : Colors.white,
            backgroundColor: !_isChecked ? Colors.white : code.checkState ? Colors.green : Colors.red
        ),),
      leading: const Icon(Icons.drag_handle),
    ),

  );
}