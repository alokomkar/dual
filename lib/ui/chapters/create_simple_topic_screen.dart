import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/ui/simple_content/simple_content.dart';
import 'package:dual_mode/widgets/bullets_widget.dart';
import 'package:dual_mode/widgets/content_widget.dart';
import 'package:dual_mode/widgets/header_widget.dart';
import 'package:dual_mode/widgets/login_button.dart';
import 'package:dual_mode/widgets/practice_button.dart';
import 'package:flutter/material.dart';

class CreateSimpleTopicScreen extends StatefulWidget {
  @override
  _CreateSimpleTopicScreenState createState() {
    return _CreateSimpleTopicScreenState();
  }
}

class _CreateSimpleTopicScreenState extends BaseState<CreateSimpleTopicScreen> {

  final List<SimpleContent> _simpleTopicsList = List();
  SimpleContent _currentContent = SimpleContent("", "", SimpleContent.header, "");

  var _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      elevation: 8,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text("Create article",
        style: buildTextStyle(22),),
      actions: <Widget>[
        GestureDetector(
          onTap: () {

          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(Icons.done_all, color: Colors.white),
          ),
        )
      ],
    ),
    body: _buildBody(),
    bottomNavigationBar: _buildDoneButton(),
  );

  @override
  void initializeData() {
    //_simpleTopicsList.add(SimpleContent("1", "Header here", SimpleContent.header, ""));
  }

  ScrollController _controller = ScrollController();

  _buildBody() => Column(
    children: <Widget>[
      Expanded(
        child: ListView.builder(
            itemBuilder: (context, itemPosition) {
          return _buildListTile(_simpleTopicsList[itemPosition]);
        },
          controller: _controller,
        scrollDirection: Axis.vertical,
          itemCount: _simpleTopicsList.length,
        ),
      ),
      Container(
        color: Colors.grey,
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Choose type :", style: buildTextStyle(14),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(color : Colors.blue, onPressed: (){ _currentContent.contentType = SimpleContent.header; }, child: Text("Header", style: buildTextStyleBlack(14),)),
                FlatButton(color : Colors.deepPurpleAccent, onPressed: (){ _currentContent.contentType = SimpleContent.content; }, child: Text("Content", style: buildTextStyleBlack(14),)),
                FlatButton(color : Colors.tealAccent, onPressed: (){ _currentContent.contentType = SimpleContent.bullets; }, child: Text("Bullets", style: buildTextStyleBlack(14),)),
                FlatButton(color : Colors.white, onPressed: (){ _currentContent.contentType = SimpleContent.code; }, child: Text("Code", style: buildTextStyleBlack(14),)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 0, 2),
              child: FlatButton(color : Colors.yellow, onPressed: (){ _currentContent.contentType = SimpleContent.image; }, child: Text("Image", style: buildTextStyleBlack(14),)),
            ),
            Container(
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
                    onSaved: (String contentString) {
                      _currentContent.contentString = contentString;
                    },
                  ),
                )
            ),
          ],
        ),
      )
    ],
  );

  Widget _buildListTile(SimpleContent displayList) {
    debugPrint("Content is : " + displayList.toString());
    switch( displayList.contentType ) {
      case SimpleContent.header :
        return HeaderWidget(displayList);

      case SimpleContent.content :
        return ContentWidget(displayList);

      case SimpleContent.bullets :
        return BulletsWidget(displayList);

      case SimpleContent.code :
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 12,),
            buildCodeBlock(displayList.contentString, 14),
            SizedBox(height: 12,),
          ],
        );

      case SimpleContent.image :
        return Container(
            padding: const EdgeInsets.all(0),
            margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
            decoration: BoxDecoration(color: Colors.grey),
            child: CachedNetworkImage(
                placeholder: (context, url) =>
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image(
                            image: AssetImage('assets/splash_logo.png')
                        ),
                        CircularProgressIndicator()
                      ],
                    ),
                errorWidget: (context, url, error) => new Icon(Icons.error),
                imageUrl: displayList.contentString
            )
        );
    }
  }

  Widget _buildDoneButton() => LoginButton(
      buttonColor: Colors.green, onClick: (){
      setState(() {
        _currentContent.contentString = _contentController.text;
        _simpleTopicsList.add(_currentContent);
      });
      _currentContent = SimpleContent("", "", SimpleContent.header, "");
      _contentController.clear();
      Timer(Duration(milliseconds: 520), () => _controller.jumpTo(_controller.position.maxScrollExtent));
  }, buttonText: "Done");
}