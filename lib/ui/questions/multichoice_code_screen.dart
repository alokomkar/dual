import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/ui/questions/question_item.dart';
import 'package:flutter/material.dart';

class MultiChoiceCodeScreen extends StatefulWidget {
  @override
  _MultiChoiceCodeScreenState createState() {
    return _MultiChoiceCodeScreenState();
  }
}

class _MultiChoiceCodeScreenState extends BaseState<MultiChoiceCodeScreen> {

  List<QuestionItem> _answersList = List();
  List<QuestionItem> _optionsList = List();
  String _questionCode = "/**\n" +
      " * The HelloWorldApp class implements an application that\n" +
      " * simply displays \"Hello World!\" to the standard output.\n" +
      " */";
  String _question = "What's this comment type?";
  bool _isChecked = false;



  @override
  void initializeData() {

    int id = 0;

    _answersList.add(QuestionItem(id++, "Multiline Comment", false));

    _optionsList.add(QuestionItem(id++, "Single line Comment", false));
    _optionsList.add(QuestionItem(id++, "Code", false));
    _optionsList.add(QuestionItem(id++, "Doesn't mean anything", false));
    _optionsList.addAll(_answersList);
    _optionsList.shuffle();

  }

  @override
  Widget build(BuildContext context) => _buildContent();

  _buildContent() => Scaffold(
    appBar: buildAppBar("Select all applicable"),
    body: _buildBody(),
    floatingActionButton: _buildFab(),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  );

  _buildFab() => FloatingActionButton(
    onPressed: () {
      setState(() {
        if( !_isChecked ) {
          for( QuestionItem option in _optionsList ) {
            if( option.checkState ) {
              option.isCorrect = _answersList.contains(option);
            }
          }
          _isChecked = true;
        }
        String solution = "";
        _answersList.forEach((QuestionItem item) {
          solution += "\n${item.value}";
        });
        buildBottomSheet(true, "Nice Work!!", solution);
      });
    },
    child: Icon(Icons.check),
    foregroundColor: Colors.white,
    backgroundColor: Colors.green,
  );

  _buildBody() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(color : Colors.black54),
          child: Text(
              _question,
              style: buildTextStyle(16),
              textAlign: TextAlign.start),
        ),
      ),
      Divider(height: 1, color: Colors.grey,),
      buildCodeBlock(_questionCode, 12),
      Divider(height: 1, color: Colors.grey,),
      Expanded(child: _buildListView()),
    ],
  );

  _buildListView() => ListView(
    scrollDirection: Axis.vertical,
    children: _optionsList.map<Widget>(_buildListTitle).toList(),
  );


  Widget _buildListTitle(QuestionItem item) => Container(
    key: Key(item.id.toString()),
    decoration: BoxDecoration(
        color: !_isChecked ? Colors.white : item.checkState && item.isCorrect ? Colors.green : Colors.red,
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1))
    ),
    child: CheckboxListTile(
      title: Text(
        item.value,
        style: TextStyle(
            fontFamily: 'VarelaRound-Regular',
            fontSize: 17,
            color: !_isChecked ? Colors.black : Colors.white,
            backgroundColor: !_isChecked ? Colors.white : item.checkState && item.isCorrect ? Colors.green : Colors.red
        ),),
      value: item.checkState,
      onChanged:( bool isChecked ) {
        setState(() {
          if( !_isChecked )
            item.checkState = isChecked;
        });
      } ,
    ),

  );


}