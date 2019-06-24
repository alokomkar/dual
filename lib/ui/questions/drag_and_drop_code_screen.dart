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
          Container(
            color: Colors.black54,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: _optionsList.map<Widget>(_buildListTitle).toList(),
                ),
              ),
            ),
            alignment: Alignment(-1, 1),
          ),
        ],
      ),
    ),
    bottomNavigationBar: LoginButton(buttonColor: Colors.green, onClick: (){}, buttonText: "Check Now",),
    //floatingActionButton: _buildFab(),
    //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  );

  Expanded _buildQuestionsListView() {
    return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: _questionsList.map<Widget>(_buildListTitle).toList(),
            ),
          ),
        );
  }

  _buildFab() => FloatingActionButton(
    onPressed: () {

    },
    child: Icon(Icons.check),
    foregroundColor: Colors.white,
    backgroundColor: Colors.green,
  );

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
            Text(item.value, style: buildTextStyleBlack(20)),
          ],
        ),
      )
  );


}