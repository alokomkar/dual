import 'dart:async';

import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/base/routes.dart';
import 'package:dual_mode/ui/chapters/chapters.dart';
import 'package:dual_mode/ui/simple_content/helper.dart';
import 'package:dual_mode/ui/simple_content/simple_content.dart';
import 'package:dual_mode/widgets/blink_button.dart';
import 'package:dual_mode/widgets/bullets_widget.dart';
import 'package:dual_mode/widgets/content_widget.dart';
import 'package:dual_mode/widgets/header_widget.dart';
import 'package:dual_mode/widgets/image_widget.dart';
import 'package:dual_mode/widgets/linear_percent_indicator.dart';
import 'package:dual_mode/widgets/practice_button.dart';
import 'package:flutter/material.dart';

class SimpleContentScreen extends StatefulWidget {
  final String _chapterTitle;

  SimpleContentScreen(this._chapterTitle);

  @override
  _SimpleContentScreenState createState() => _SimpleContentScreenState();
}

class _SimpleContentScreenState extends BaseState<SimpleContentScreen> {
  List<SimpleContent> _simpleContentList;
  List<SimpleContent> _displayList = List();
  int _currentIndex = 0;
  ScrollController _controller = ScrollController();
  String title = "";
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  bool _showProgressBar = false;

  @override
  void initializeData() {
    title = "Introduction";
    List<SimpleContent> _originalList = getOOFirstContent();
    _simpleContentList = List();
    _originalList.forEach((item) {
      if (item.contentType == SimpleContent.bullets) {
        item.contentString.split("\n").forEach((contentString) {
          _simpleContentList
              .add(SimpleContent("", contentString, SimpleContent.bullets, ""));
        });
      } else {
        _simpleContentList.add(item);
      }
    });

    _displayList.add(_simpleContentList[_currentIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title),
      drawer: _buildDrawer(),
      body: Stack(
        children: <Widget>[_buildListView(), _buildProgressIndicator()],
      ),
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  FloatingActionButton _buildFab() => FloatingActionButton(
        onPressed: () {
          if (_currentIndex < _simpleContentList.length - 1) {
            //initializeControllerTextAnimation();
            setState(() {
              //_listKey.currentState.insertItem(_displayList.length, duration: Duration(milliseconds: 500));
              _displayList.add(_simpleContentList[++_currentIndex]);
              _showProgressBar =
                  _currentIndex == (_simpleContentList.length - 1);
            });
            //_controller.animateTo(_controller.position.maxScrollExtent, duration: Duration(milliseconds: 700), curve: Curves.easeOut);
            //_controller.jumpTo(_controller.position.maxScrollExtent);
            Timer(Duration(milliseconds: 520),
                () => _controller.jumpTo(_controller.position.maxScrollExtent));
          }
        },
        child: Icon(Icons.navigate_next),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueGrey,
      );

  _buildAnimatedListView() => AnimatedList(
      controller: _controller,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 72),
      key: _listKey,
      initialItemCount: _displayList.length,
      itemBuilder: (context, position, animation) {
        return _buildAnimatedItemView(
            _displayList[position], position, animation);
        /*SlideTransition(
          position: animation.drive(Tween(begin: Offset(200, 0.0), end: Offset.zero)),
          child: _buildItemView(_displayList[position])*/ /*_buildAnimatedItemView( _displayList[position], position, animation )*/ /*,
        );*/
      });

  _buildAnimatedItemView(SimpleContent displayList, int position,
          Animation<double> animation) =>
      SizeTransition(
        key: ValueKey(position),
        axis: Axis.vertical,
        sizeFactor: animation,
        child: _buildItemView(displayList),
      );

  _buildItemView(SimpleContent displayList) {
    switch (displayList.contentType) {
      case SimpleContent.header:
        return HeaderWidget(displayList);

      case SimpleContent.content:
        return ContentWidget(displayList);

      case SimpleContent.bullets:
        return BulletsWidget(displayList);

      case SimpleContent.code:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 44,
              width: 130,
              child: PracticeButton(
                  buttonColor: Colors.green,
                  buttonText: "Practice Now",
                  onClick: () => _initPractice(displayList.contentString)),
            ),
            buildCodeBlock(displayList.contentString, 14),
            SizedBox(
              height: 12,
            ),
          ],
        );

      case SimpleContent.image:
        return ImageWidget(displayList.contentString);

      case SimpleContent.mcq:
        return _buildQuestionContainer(
            Colors.red, "Multi choice", "/multi_choice");

      case SimpleContent.codeMcq:
        return _buildQuestionContainer(
            Colors.cyan, "Code Quiz", "/multi_choice_code");

      case SimpleContent.drag_and_drop:
        return _buildQuestionContainer(
            Colors.black54, "Fill blanks", "/drag_and_drop");

      case SimpleContent.syntaxLearn:
        return _buildQuestionContainer(
            Colors.blueGrey, "Learn syntax", "/syntax_learn");

      default:
        return HeaderWidget(displayList);
    }
  }

  _initPractice(String contentString) {
    Navigator.of(context).pushNamed(RearrangeCodeScreenRoute);
  }

  _buildDrawer() => Drawer(
        child: _buildSubTopicsListView(),
      );

  _buildSubTopicsListView() {
    final List<Chapter> chapterList =
        Chapter.getChaptersByTitle(widget._chapterTitle);
    return ListView(
      scrollDirection: Axis.vertical,
      children: chapterList.map<Widget>(_buildSubTopicView).toList(),
    );
  }

  Widget _buildSubTopicView(Chapter chapter) => Container(
        key: Key(chapter.moduleTitle.toString()),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
        child: ListTile(
          title: Text(
            chapter.moduleTitle,
            style: TextStyle(
                fontFamily: 'VarelaRound-Regular',
                fontSize: 17,
                color: Colors.black,
                backgroundColor: Colors.white),
          ),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              title = chapter.moduleTitle;
            });
          },
        ),
      );

  _buildQuestionContainer(Color color, String title, String path) =>
      BlinkButton(color, path);

  _buildListView() {
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 72),
        key: _listKey,
        controller: _controller,
        itemCount: _displayList.length,
        itemBuilder: (context, itemPosition) {
          return _buildItemView(_displayList[itemPosition]);
        });
  }

  _buildProgressIndicator() {
    if (_showProgressBar)
      return Container(
        color: Colors.black87,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 12, 16, 8),
                  child: new LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 100,
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 2000,
                      percent: 0.9,
                      //center: Text("90.0%"),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.green,
                      onClick: () {
                        setState(() {
                          _showProgressBar = false;
                        });
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Icon(Icons.close, color: Colors.white),
                    onTap: () {
                      setState(() {
                        _showProgressBar = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(
                "Congratulations!!",
                style: buildTextStyle(15),
              ),
            ),
          ],
        ),
      );
    else
      return Container();
  }
}
