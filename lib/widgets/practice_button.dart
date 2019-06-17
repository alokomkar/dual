import 'package:flutter/material.dart';

class PracticeButton extends StatelessWidget {

  final Color buttonColor;
  final Function onClick;
  final String buttonText;

  PracticeButton({this.buttonColor, this.onClick, this.buttonText});

  _buildText() => Text(
    buttonText,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontFamily: 'VarelaRound-Regular',
      fontSize: 16,
      color: Colors.white,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 20,
      onPressed: this.onClick,
      color: buttonColor,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildText(),
        ],
      ),
    );
  }

}