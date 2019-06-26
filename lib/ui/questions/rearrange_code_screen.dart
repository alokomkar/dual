import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/ui/questions/question_item.dart';
import 'package:flutter/material.dart';

class RearrangeCodeScreen extends StatefulWidget {
  @override
  _RearrangeCodeScreenState createState() {
    return _RearrangeCodeScreenState();
  }
}

class _RearrangeCodeScreenState extends BaseState<RearrangeCodeScreen> {

  List<QuestionItem> _originalList = List();
  List<QuestionItem> _modifiedList = List();
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: buildAppBar("Reorder"),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color : Colors.black54),
            child: Text(
                "Rearrange in the correct order",
                style: buildTextStyle(16),
                textAlign: TextAlign.start),
          ),
        ),
        Divider(height: 1, color: Colors.grey,),
        Expanded(child: _buildListView(),),
      ],
    ),
    floatingActionButton: _buildFab(),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  );

  _buildListView() => !_isChecked ? ReorderableListView(
    onReorder: _onReorder,
    children: _modifiedList.map<Widget>(_buildListTitle).toList(),
  )
      :
  ListView(
    scrollDirection: Axis.vertical,
    children: _modifiedList.map<Widget>(_buildListTitle).toList(),
  );

  _buildFab() => FloatingActionButton(
    onPressed: () {
      setState(() {
        int index = 0;
        _modifiedList.forEach((QuestionItem item) {
          item.checkState = item.value == _originalList[index++].value;
        });
        _isChecked = true;
      });
      String solution = "";
      _originalList.forEach((QuestionItem item) {
        solution += "\n${item.value}";
      });
      buildBottomSheet(true, "Nice Work!!", solution);
    },
    child: Icon(Icons.check),
    foregroundColor: Colors.white,
    backgroundColor: Colors.green,
  );

  @override
  void initializeData() {

    //Generating unique id to ensure key is always unique. - don't remove this

    int id = 0;
    _originalList.add(QuestionItem(id++, "class HelloWorld {", false));
    _originalList.add(QuestionItem(id++, "public static void main( String args[] ) {", false));
    _originalList.add(QuestionItem(id++, "System.out.println(\"Hello World\");", false));
    _originalList.add(QuestionItem(id++, "}", false));
    _originalList.add(QuestionItem(id++, "}", false));

    _modifiedList.addAll(_originalList);
    _modifiedList.shuffle();
  }

  void _onReorder(int oldIndex, int newIndex) {
    if( !_isChecked ) {
      setState(() {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final QuestionItem item = _modifiedList.removeAt(oldIndex);
        _modifiedList.insert(newIndex, item);
      });
    }
  }

  Widget _buildListTitle(QuestionItem code) => Container(
    key: Key(code.id.toString()),
    decoration: BoxDecoration(
        color: !_isChecked ? Colors.white : code.checkState ? Colors.green : Colors.red,
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1))
    ),
    child: ListTile(
      title: Text(
        code.value,
        style: TextStyle(
            fontFamily: 'VarelaRound-Regular',
            fontSize: 17,
            color: !_isChecked ? Colors.black : Colors.white,
            backgroundColor: !_isChecked ? Colors.white : code.checkState ? Colors.green : Colors.red
        ),),
      leading: const Icon(Icons.drag_handle),
    ),

  );
}