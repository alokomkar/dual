import 'package:dual_mode/base/base_interaction_listener.dart';
import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/ui/simple_content/simple_content.dart';
import 'package:flutter/material.dart';

import 'login_button.dart';

class OptionTypeWidget extends StatefulWidget {
  final BaseInteractionListener<int> _baseInteractionListener;

  OptionTypeWidget(this._baseInteractionListener);

  @override
  _OptionTypeWidgetState createState() {
    return _OptionTypeWidgetState();
  }
}

class _OptionTypeWidgetState extends BaseState<OptionTypeWidget> {
  int _currentChoice = -1;
  @override
  Widget build(BuildContext context) => Container(
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
                    widget._baseInteractionListener.onCancel("");
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

  Widget _buildOption(int contentType, String description) => Card(
      elevation: 4,
      color: _currentChoice == contentType ? Colors.green : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentChoice = contentType;
          });
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
              child: Text(
            description,
            style: _currentChoice == contentType
                ? buildTextStyle(16)
                : buildTextStyleBlack(16),
          )),
        ),
      ));

  Widget _buildDoneButton() => LoginButton(
      buttonColor: Colors.green,
      onClick: () {
        widget._baseInteractionListener.onSuccess(_currentChoice);
      },
      buttonText: "Done");

  @override
  void initializeData() {}
}
