import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/ui/questions/question_item.dart';
import 'package:dual_mode/widgets/login_button.dart';
import 'package:flutter/material.dart';

class DragNDropCodeScreen extends StatefulWidget {
  @override
  _DragNDropCodeScreenState createState() {
    return _DragNDropCodeScreenState();
  }
}

class _DragNDropCodeScreenState extends BaseState<DragNDropCodeScreen> {

  List<QuestionItem> _originalList = List();
  List<QuestionItem> _questionsList = List();
  List<QuestionItem> _optionsList = List();

  bool _isChecked = false;

  @override
  void initializeData() {

    int id = 0;
    _originalList.add(QuestionItem(id++, "class HelloWorld {", false));
    _originalList.add(QuestionItem(id++, "public static void main( String args[] ) {", false));
    _originalList.add(QuestionItem(id++, "System.out.println(\"Hello World\");", false));
    _originalList.add(QuestionItem(id++, "}", false));
    _originalList.add(QuestionItem(id++, "}", false));

    //_questionsList.addAll(_originalList);
    _questionsList.add(QuestionItem(id++, "", false));
    _questionsList.add(QuestionItem(id++, "", false));
    _questionsList.add(QuestionItem(id++, "", false));
    _questionsList.add(QuestionItem(id++, "}", false));
    _questionsList.add(QuestionItem(id++, "}", false));

    _optionsList.add(QuestionItem(id++, "class HelloWorld {", false));
    _optionsList.add(QuestionItem(id++, "public static void main( String args[] ) {", false));
    _optionsList.add(QuestionItem(id++, "System.out.println(\"Hello World\");", false));
    _optionsList.shuffle();

  }

  @override
  Widget build(BuildContext context) => _buildContent();

  _buildContent() => Scaffold(
    appBar: buildAppBar("Drag and drop"),
    body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildQuestionsListView(),
          _buildOptionsContainer(),
        ],
      ),
    ),
    bottomNavigationBar: LoginButton(buttonColor: Colors.green, onClick: (){

      int codeLines = _originalList.length;
      int correctCode = 0;

      if( !_isChecked ) {
        _isChecked = true;
        solution = "";
        int index = 0;

        _questionsList.forEach((QuestionItem item) {
          solution += "\n${_originalList[index].value}";
          item.isCorrect = item.value == _originalList[index++].value;
          if( item.isCorrect ) ++correctCode;
        });
        setState(() {

        });
      }
      bool isCorrect = codeLines == correctCode;
      buildBottomSheet(isCorrect, isCorrect ? "Nice work!!" : "Hmmm!" , solution);
    }, buttonText: "Check Now",),
  );

  String solution = "";

  Container _buildOptionsContainer() {
    return Container(
      color: Colors.black54,
      child: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: _optionsList.map<Widget>(_buildDraggableListTitle).toList(),
            ),
          ),
        ),
      ),
      alignment: Alignment(-1, 1),
    );
  }

  Expanded _buildQuestionsListView() {
    return Expanded(
      child: Container(
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: _questionsList.map<Widget>(_buildDragTarget).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildListTitle(QuestionItem item) => Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(item.value, style: TextStyle(
              fontFamily: 'VarelaRound-Regular',
              fontSize: 20,
              color: _getItemColor(item),
            )),
          ],
        ),
      )
  );

  Widget _buildDraggableListTitle(QuestionItem item) {
    Widget listTile = _buildListTitle(item);
    if( !_isChecked ) {
      return Draggable(
        data: item,
        child: listTile,
        feedback: listTile,
        childWhenDragging: listTile,
      );
    }
    else return listTile;
  }

  Widget _buildDragTarget(QuestionItem item) {
    if( !_isChecked && item.isQuestion ) {
      return DragTarget(
        builder: (context, List<QuestionItem> candidateData, rejectedData) {
          return _buildListTitle(item);
        },
        onAccept:(data) {
          item.value = data.value;
          setState(() {

          });
        },
        onWillAccept: (data) {
          return item.isQuestion;
        },
      );
    }
    else return _buildListTitle(item);

  }

  Color _getItemColor(QuestionItem item) {
    if( item.isQuestion ) {
      return !_isChecked ? Colors.black : item.isCorrect ? Colors.green : Colors.red;
    }
    else return Colors.black;
  }
}