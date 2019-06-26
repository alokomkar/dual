import 'package:dual_mode/base/base_state.dart';
import 'package:flutter/material.dart';

class SyntaxLearnScreen extends StatefulWidget {
  @override
  _SyntaxLearnScreenState createState() {
    return _SyntaxLearnScreenState();
  }
}

class _SyntaxLearnScreenState extends BaseState<SyntaxLearnScreen> {

  String _solution = "public static void main( String[] args ) {}";
  String _userSolution = "";
  List<String> _optionsList = List();
  List<String> _answersList = List();

  bool _isChecked = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new
  GlobalKey<ScaffoldState>();

  bool _isCorrect = false;

  @override
  void initializeData() {
    _optionsList.addAll(_solution.split(" "));
    _optionsList.shuffle();
  }

  @override
  Widget build(BuildContext context) => _buildContent();

  _buildContent() => Scaffold(
    appBar: buildAppBar("Syntax learn"),
    body: _buildBody(),
    floatingActionButton: _buildFab(),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    //bottomSheet: _buildBottomSheet(),
  );

  _buildBody() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: FlatButton(onPressed: () {
            setState(() {
              if( !_isChecked ) {
                _answersList.removeLast();
                _userSolution = "";
                _answersList.forEach((answer) {
                  _userSolution += answer + " ";
                });
              }
            });
          },
            padding: EdgeInsets.all(14),
            child: Icon(Icons.backspace, color: Colors.white,),
            color: Colors.red,),
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(color : Colors.black54),
          child: Text(
              "Complete the syntax",
              style: buildTextStyle(14),
              textAlign: TextAlign.start),
        ),
      ),
      Divider(height: 1, color: Colors.grey,),
      buildCodeBlock(_userSolution, 14),
      Divider(height: 1, color: Colors.grey,),
      Expanded(child: _buildListView())
    ],
  );

  _buildFab() => FloatingActionButton(
    onPressed: () {
      setState(() {
        if( !_isChecked ) {
          _isCorrect = _userSolution.trim() == _solution;
          _isChecked = true;
        }
        _showBottomSheet(_isCorrect ? "Correct!!\n" : "Hmm!!\n");
      });
    },
    child: Icon(Icons.check),
    foregroundColor: Colors.white,
    backgroundColor: Colors.green,
  );

  _buildListView() => Padding( padding: EdgeInsets.all(4),
      child: GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 2.5,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: _optionsList.map<Widget>(_buildListTitle).toList(),
      ));

  Widget _buildListTitle(String item) => GestureDetector(
      onTap: () {
        setState(() {
          if( !_isChecked ) {
            _answersList.add(item);
            _userSolution = "";
            _answersList.forEach((answer) {
              _userSolution += answer + " ";
            });
          }
        });

      },
      child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.black54,
          child : Center(
            child: Text(item, style: TextStyle(
              fontFamily: 'VarelaRound-Regular',
              fontSize: 20,
              color: Colors.white,
            )),
          )
      )
  );

  _buildBottomSheet(String message) => Container(
    key: _scaffoldKey,
    color: Colors.black54,
    padding: EdgeInsets.all(8),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          color: Colors.black,
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(message, style: TextStyle(
                fontFamily: 'VarelaRound-Regular',
                fontSize: 16,
                color:  _isCorrect ? Colors.green : Colors.red,
              ),
              ),
              Text("That's how you write the main function :\n" + _solution, style: buildTextStyle(16),
              ),
            ],
          )),
    ),

  );

  void _showBottomSheet(String message) => showModalBottomSheet(context: context, builder: (BuildContext builderContext) {
    return _buildBottomSheet(message);
  });


}