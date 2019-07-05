import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/ui/simple_content/simple_content.dart';
import 'package:dual_mode/widgets/bullets_widget.dart';
import 'package:dual_mode/widgets/content_widget.dart';
import 'package:dual_mode/widgets/header_widget.dart';
import 'package:dual_mode/widgets/login_button.dart';
import 'package:flutter/material.dart';

class CreateSimpleTopicScreen extends StatefulWidget {
  @override
  _CreateSimpleTopicScreenState createState() {
    return _CreateSimpleTopicScreenState();
  }
}

class _CreateSimpleTopicScreenState extends BaseState<CreateSimpleTopicScreen> {
  final List<SimpleContent> _simpleTopicsList = List();
  SimpleContent _currentContent =
      SimpleContent("", "", SimpleContent.header, "");

  var _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[_buildBody(), _buildCard()],
      ));

  AppBar _buildAppBar() => AppBar(
        elevation: 8,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text(
          "Create article",
          style: buildTextStyle(22),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.done_all, color: Colors.white),
            ),
          )
        ],
      );

  @override
  void initializeData() {
    _simpleTopicsList.add(SimpleContent(
        "1", "Simple program AKA Hello World", SimpleContent.header, ""));
    _simpleTopicsList.add(SimpleContent(
        "1",
        "The quintessential program all programmers have to start with - Hello World",
        SimpleContent.content,
        ""));
    _simpleTopicsList.add(SimpleContent("1",
        "public static void main(String[] args){}", SimpleContent.code, ""));
    _simpleTopicsList.add(SimpleContent(
        "1",
        "public - access specifier which means method is accessible publically.",
        SimpleContent.bullets,
        ""));
    _simpleTopicsList.add(SimpleContent(
        "1",
        "static - indicates the method is class specific and doesn't require creation of an object to use it.",
        SimpleContent.bullets,
        ""));
    _simpleTopicsList.add(SimpleContent(
        "1",
        "void - indicates the method isn't going to return anything.",
        SimpleContent.bullets,
        ""));
    _simpleTopicsList.add(SimpleContent(
        "1",
        "main - the starting point for any Java program.",
        SimpleContent.bullets,
        ""));
    _simpleTopicsList.add(SimpleContent(
        "1",
        "String[] args - arguments from the command line are passed to program via args - an array of Strings.",
        SimpleContent.bullets,
        ""));
  }

  ScrollController _controller = ScrollController();

  _buildBody() => Column(
        children: <Widget>[
          Expanded(
            child: _buildContentList(),
          ),
          _buildInputContainer()
        ],
      );

  Container _buildInputContainer() {
    return Container(
      color: Colors.grey,
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildInputLayout(),
        ],
      ),
    );
  }

  Widget _buildListTile(SimpleContent displayList) {
    debugPrint("Content is : " + displayList.toString());
    switch (displayList.contentType) {
      case SimpleContent.header:
        return GestureDetector(
          onLongPress: () {
            setState(() {
              _currentContent = displayList;
            });
          },
          child: HeaderWidget(displayList),
        );

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
            buildCodeBlock(displayList.contentString, 14),
            SizedBox(
              height: 12,
            ),
          ],
        );

      case SimpleContent.image:
        return Container(
            padding: const EdgeInsets.all(0),
            margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
            decoration: BoxDecoration(color: Colors.grey),
            child: CachedNetworkImage(
                placeholder: (context, url) => Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image(image: AssetImage('assets/splash_logo.png')),
                        CircularProgressIndicator()
                      ],
                    ),
                errorWidget: (context, url, error) => new Icon(Icons.error),
                imageUrl: displayList.contentString));
    }
  }

  Widget _buildDoneButton() => LoginButton(
      buttonColor: Colors.green,
      onClick: () {
        _addSimpleContent();
      },
      buttonText: "Done");

  ListView _buildContentList() => ListView.builder(
        itemBuilder: (context, itemPosition) {
          return _buildListTile(_simpleTopicsList[itemPosition]);
        },
        controller: _controller,
        scrollDirection: Axis.vertical,
        itemCount: _simpleTopicsList.length,
      );

  void _addSimpleContent() {
    setState(() {
      _currentContent.contentString = _contentController.text;
      _simpleTopicsList.add(_currentContent);
      _showOptionsView = !_showOptionsView;
    });
    _currentContent = SimpleContent("", "", SimpleContent.header, "");
    _contentController.clear();
    Timer(Duration(milliseconds: 520),
        () => _controller.jumpTo(_controller.position.maxScrollExtent));
  }

  _buildInputLayout() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[_buildTextForm(), _buildSendButton()],
      );

  Widget _buildTextForm() => Flexible(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: buildTextStyleBlack(16),
              decoration: InputDecoration.collapsed(hintText: "Type here..."),
              maxLines: 10,
              minLines: 3,
              controller: _contentController,
              keyboardType: TextInputType.multiline,
              initialValue:
                  _currentContent != null ? _currentContent.contentString : "",
              onSaved: (String contentString) {
                _currentContent.contentString = contentString;
              },
            ),
          ),
        ),
      );

  bool _showOptionsView = false;

  Widget _buildSendButton() => Container(
        child: GestureDetector(
          onTap: () {
            //_showOptions();
            setState(() {
              _showOptionsView = !_showOptionsView;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ),
      );

  final GlobalKey _optionsKey = GlobalKey();

  void _showOptions() => showModalBottomSheet(
      context: context,
      builder: (BuildContext builderContext) {
        return _buildCard();
      });

  Widget _buildCard() {
    if (_showOptionsView)
      return Container(
        color: Colors.black54,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showOptionsView = !_showOptionsView;
                    });
                  },
                  child: Container(
                    alignment: AlignmentDirectional.topEnd,
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
                ),
                Row(
                  key: _optionsKey,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildOption(SimpleContent.header, "Header"),
                    _buildOption(SimpleContent.content, "Content"),
                    _buildOption(SimpleContent.bullets, "Bullets"),
                    _buildOption(SimpleContent.code, "Code"),
                    _buildOption(SimpleContent.image, "Image"),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                _buildDoneButton()
              ],
            ),
          ),
        ),
      );
    else
      return Container();
  }

  Widget _buildOption(int contentType, String description) => Card(
      elevation: 4,
      color: _currentContent.contentType == contentType
          ? Colors.green
          : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentContent.contentType = contentType;
          });
          _optionsKey.currentState.setState(() {});
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
              child: Text(
            description,
            style: _currentContent.contentType == contentType
                ? buildTextStyle(16)
                : buildTextStyleBlack(16),
          )),
        ),
      ));
}
