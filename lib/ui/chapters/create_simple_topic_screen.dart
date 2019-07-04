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

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: buildAppBar("Create New Article"),
    body: _buildBody(),
    bottomNavigationBar: _buildDoneButton(),
  );

  @override
  void initializeData() {}

  _buildBody() => Column(
    children: <Widget>[
      Expanded(
        child: ListView.builder(itemBuilder: (context, itemPosition) {
          return _buildListTile(_simpleTopicsList[itemPosition]);
        }),
      ),
      Container(
        color: Colors.black87,
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Text("Choose type :", style: buildTextStyleBlack(14),),
            Row(
              children: <Widget>[
                FlatButton(onPressed: (){}, child: Text("Header", style: buildTextStyleBlack(14),)),
                FlatButton(onPressed: (){}, child: Text("Bullets", style: buildTextStyleBlack(14),)),
                FlatButton(onPressed: (){}, child: Text("Code", style: buildTextStyleBlack(14),)),
                FlatButton(onPressed: (){}, child: Text("Image", style: buildTextStyleBlack(14),)),
              ],
            ),
            TextFormField(),
          ],
        ),
      )
    ],
  );

  Widget _buildListTile(SimpleContent displayList) {
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
            SizedBox(
              height: 44,
              width: 130,
              child: PracticeButton(
                  buttonColor: Colors.green,
                  buttonText: "Practice Now",
                  onClick: () {

                  }),
            ),
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

  }, buttonText: "Done");
}