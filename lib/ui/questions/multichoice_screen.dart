import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/ui/questions/question_item.dart';
import 'package:flutter/material.dart';

class MultiChoiceScreen extends StatefulWidget {
  @override
  _MultiChoiceScreenState createState() {
    return _MultiChoiceScreenState();
  }
}

class _MultiChoiceScreenState extends BaseState<MultiChoiceScreen> {

  List<QuestionItem> _answersList = List();
  List<QuestionItem> _optionsList = List();
  bool _isChecked = false;

  @override
  void initializeData() {
    
    int id = 0;
    
    _answersList.add(QuestionItem(id++, "Object Oriented", false));
    _answersList.add(QuestionItem(id++, "Distributed", false));
    _answersList.add(QuestionItem(id++, "Multithreaded", false));
    _answersList.add(QuestionItem(id++, "Architecture neutral", false));
    
    _optionsList.add(QuestionItem(id++, "Not dynamic", false));
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
      int codeLines = _answersList.length;
      int correctCode = 0;
      setState(() {
        if( !_isChecked ) {
          for( QuestionItem option in _optionsList ) {
            if( option.checkState ) {
              option.isCorrect = _answersList.contains(option);
              if( option.isCorrect ) correctCode++;
            }
          }
          _isChecked = true;
        }
        String solution = "";
        _answersList.forEach((QuestionItem item) {
          solution += "\n${item.value}";
        });
        bool isCorrect = codeLines == correctCode;
        buildBottomSheet(isCorrect, isCorrect ? "That's correct.." : "Not exactly!", solution);
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
              "Java is :",
              style: buildTextStyle(16),
              textAlign: TextAlign.start),
        ),
      ),
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