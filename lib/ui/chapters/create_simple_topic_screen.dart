import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dual_mode/base/base_interaction_listener.dart';
import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/ui/simple_content/helper.dart';
import 'package:dual_mode/ui/simple_content/simple_content.dart';
import 'package:dual_mode/widgets/bullets_widget.dart';
import 'package:dual_mode/widgets/content_widget.dart';
import 'package:dual_mode/widgets/header_widget.dart';
import 'package:dual_mode/widgets/option_type_widget.dart';
import 'package:flutter/material.dart';

class CreateSimpleTopicScreen extends StatefulWidget {
  @override
  _CreateSimpleTopicScreenState createState() {
    return _CreateSimpleTopicScreenState();
  }
}

class _CreateSimpleTopicScreenState extends BaseState<CreateSimpleTopicScreen>
    implements BaseInteractionListener<int> {
  final List<SimpleContent> _simpleTopicsList = List();
  SimpleContent _currentContent =
      SimpleContent("", "", SimpleContent.header, "");

  List<SimpleContent> _selectedContentList = List();

  var _contentController = TextEditingController();
  var _scaffoldCreateTopicKey = GlobalKey<ScaffoldState>();
  var _showExtraOptions = false;

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: _checkExtrasMenu,
        child: Scaffold(
            key: _scaffoldCreateTopicKey,
            appBar: _buildAppBar(),
            body: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[_buildBody()],
            )),
      );

  AppBar _buildAppBar() => AppBar(
      elevation: 8,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text(
        "Create article",
        style: buildTextStyle(22),
      ),
      actions: _showExtraOptions
          ? <Widget>[
              GestureDetector(
                onTap: () {
                  if (_selectedContentList.length == 1) {
                    setState(() {
                      _contentController.text = _currentContent.contentString;
                      _showExtraOptions = false;
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.edit,
                      color: _selectedContentList.length == 1
                          ? Colors.white
                          : Colors.transparent),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedContentList
                        .forEach((item) => _simpleTopicsList.remove(item));
                    _selectedContentList.clear();
                    _showExtraOptions = false;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ]
          : <Widget>[
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.done_all, color: Colors.white),
                ),
              ),
            ]);

  @override
  void initializeData() {
    _simpleTopicsList.addAll(getCreateSimpleContentList());
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

  Widget _buildListTile(SimpleContent simpleContent) {
    switch (simpleContent.contentType) {
      case SimpleContent.header:
        return GestureDetector(
          onLongPress: () {
            _invokeExtrasMenu(simpleContent);
          },
          onTap: () {
            _removeContent(simpleContent);
          },
          child: Container(
              color: _showExtraOptions &&
                      _selectedContentList.contains(simpleContent)
                  ? Colors.black26
                  : Colors.transparent,
              padding: _showExtraOptions &&
                      _selectedContentList.contains(simpleContent)
                  ? EdgeInsets.fromLTRB(0, 8, 0, 8)
                  : EdgeInsets.all(0),
              child: HeaderWidget(simpleContent)),
        );

      case SimpleContent.content:
        return GestureDetector(
          onLongPress: () {
            _invokeExtrasMenu(simpleContent);
          },
          onTap: () {
            _removeContent(simpleContent);
          },
          child: Container(
              color: _showExtraOptions &&
                      _selectedContentList.contains(simpleContent)
                  ? Colors.black26
                  : Colors.transparent,
              padding: _showExtraOptions &&
                      _selectedContentList.contains(simpleContent)
                  ? EdgeInsets.fromLTRB(0, 8, 0, 8)
                  : EdgeInsets.all(0),
              child: ContentWidget(simpleContent)),
        );

      case SimpleContent.bullets:
        return GestureDetector(
          onLongPress: () {
            _invokeExtrasMenu(simpleContent);
          },
          onTap: () {
            _removeContent(simpleContent);
          },
          child: Container(
              color: _showExtraOptions &&
                      _selectedContentList.contains(simpleContent)
                  ? Colors.black26
                  : Colors.transparent,
              padding: _showExtraOptions &&
                      _selectedContentList.contains(simpleContent)
                  ? EdgeInsets.fromLTRB(0, 8, 0, 8)
                  : EdgeInsets.all(0),
              child: BulletsWidget(simpleContent)),
        );

      case SimpleContent.code:
        return GestureDetector(
          onLongPress: () {
            _invokeExtrasMenu(simpleContent);
          },
          onTap: () {
            _removeContent(simpleContent);
          },
          child: Container(
            color: _showExtraOptions &&
                    _selectedContentList.contains(simpleContent)
                ? Colors.black26
                : Colors.transparent,
            padding: _showExtraOptions &&
                    _selectedContentList.contains(simpleContent)
                ? EdgeInsets.fromLTRB(0, 8, 0, 8)
                : EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: 12,
                ),
                buildCodeBlock(simpleContent.contentString, 14),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        );

      case SimpleContent.image:
        return GestureDetector(
          onLongPress: () {
            _invokeExtrasMenu(simpleContent);
          },
          onTap: () {
            _removeContent(simpleContent);
          },
          child: Container(
            color: _showExtraOptions &&
                    _selectedContentList.contains(simpleContent)
                ? Colors.black26
                : Colors.transparent,
            padding: _showExtraOptions &&
                    _selectedContentList.contains(simpleContent)
                ? EdgeInsets.fromLTRB(0, 8, 0, 8)
                : EdgeInsets.all(0),
            child: Container(
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
                    imageUrl: simpleContent.contentString.trim())),
          ),
        );
    }
  }

  void _removeContent(SimpleContent simpleContent) {
    if (_selectedContentList.contains(simpleContent)) {
      _selectedContentList.remove(simpleContent);
      _showExtraOptions = _selectedContentList.isNotEmpty;
      setState(() {});
    } else {
      _invokeExtrasMenu(simpleContent);
    }
  }

  void _invokeExtrasMenu(SimpleContent simpleContent) {
    if (_selectedContentList.length == 0) _currentContent = simpleContent;

    _selectedContentList.add(simpleContent);
    setState(() {
      _showExtraOptions = true;
    });
  }

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
      if (_simpleTopicsList.contains(_currentContent)) {
        _simpleTopicsList[_simpleTopicsList.indexOf(_currentContent)] =
            _currentContent;
      } else {
        _simpleTopicsList.add(_currentContent);
        Timer(Duration(milliseconds: 520),
            () => _controller.jumpTo(_controller.position.maxScrollExtent));
      }
    });
    _contentController.clear();
    _currentContent = SimpleContent("", "", SimpleContent.header, "");
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
              validator: _validateTopic,
              controller: _contentController,
              keyboardType: TextInputType.multiline,
              onSaved: (String contentString) {
                _currentContent.contentString = contentString;
              },
            ),
          ),
        ),
      );

  Widget _buildSendButton() => Container(
        child: GestureDetector(
          onTap: () {
            String content = _contentController.text.trim();
            if (content.isNotEmpty) {
              String text = content.toLowerCase();
              if (text.startsWith("http") &&
                  (text.endsWith(".jpg") ||
                      text.endsWith(".png") ||
                      text.endsWith(".webp") ||
                      text.endsWith(".jpeg") ||
                      text.endsWith(".gif"))) {
                _currentContent.contentType = SimpleContent.image;
                _currentContent.contentString = content;
                _addSimpleContent();
              } else
                _showOptions();
            } else
              _showSnackBar("Enter at least one line");
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

  void _showOptions() => showModalBottomSheet(
      context: context,
      builder: (BuildContext builderContext) {
        return OptionTypeWidget(_currentContent.contentType, this);
      });

  @override
  void onCancel(String error) {
    Navigator.pop(context);
  }

  @override
  void onSuccess(int item) {
    _currentContent.contentType = item;
    _addSimpleContent();
    Navigator.pop(context);
  }

  _showSnackBar(String message) => _scaffoldCreateTopicKey.currentState
      .showSnackBar(SnackBar(content: Text(message)));

  String _validateTopic(String value) {
    return value.isEmpty ? "Required" : null;
  }

  Future<bool> _checkExtrasMenu() {
    if (_showExtraOptions) {
      _selectedContentList.clear();
      setState(() {
        _showExtraOptions = false;
      });
      return Future.value(false);
    } else {
      Navigator.pop(context);
      return null;
    }
  }
}
