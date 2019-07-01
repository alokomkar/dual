import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/ui/simple_content/simple_content.dart';
import 'package:flutter/material.dart';

class BulletsWidget extends StatefulWidget {

  final SimpleContent _displayList;
  BulletsWidget(this._displayList);

  @override
  _BulletsWidgetState createState() {
    return _BulletsWidgetState(_displayList);
  }
}

class _BulletsWidgetState extends BaseState<BulletsWidget> with TickerProviderStateMixin  {

  AnimationController _controllerText;
  Animation<double> _animationText;
  SimpleContent _displayList;

  _BulletsWidgetState(this._displayList);

  @override
  void initializeData() {
    initializeControllerTextAnimation();
    _controllerText.forward();
  }

  void initializeControllerTextAnimation() {
    _controllerText = new AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animationText = new Tween(begin: -300.0, end: 0.0).animate(
      new CurvedAnimation(
        parent: _controllerText,
        curve:Curves.easeInOut,
      ),
    );
    _animationText.addListener((){
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
        transform: new Matrix4.translationValues(
            _animationText.value, 0.0, 0.0),
        child : Container(
          //duration: Duration(milliseconds: _animationDuration),
            padding: const EdgeInsets.all(12),
            margin: EdgeInsets.fromLTRB(0, 8, 32, 8),
            decoration: BoxDecoration(color: Colors.grey[200]),
            child : Text(_displayList.contentString, style: buildTextSimpleContentBlack(16, Colors.grey[200]))
        ));
  }
}