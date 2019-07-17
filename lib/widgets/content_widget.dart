import 'package:dual_mode/base/base_state.dart';
import 'package:dual_mode/ui/simple_content/simple_content.dart';
import 'package:flutter/material.dart';

class ContentWidget extends StatefulWidget {
  final SimpleContent _displayList;
  ContentWidget(this._displayList);

  @override
  _ContentWidgetState createState() {
    return _ContentWidgetState(_displayList);
  }
}

class _ContentWidgetState extends BaseState<ContentWidget>
    with TickerProviderStateMixin {
  AnimationController _controllerText;
  Animation<double> _animationText;
  SimpleContent _displayList;

  _ContentWidgetState(this._displayList);

  @override
  void initializeData() {
    initializeControllerTextAnimation();
    _controllerText.forward();
    _controllerText.addStatusListener((AnimationStatus status) {
      switch (status) {
        case AnimationStatus.completed:
          _displayList.isAnimationPending = false;
          break;
        default:
          break;
      }
    });
  }

  void initializeControllerTextAnimation() {
    _controllerText = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animationText = Tween(begin: 300.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controllerText,
        curve: Curves.easeInOut,
      ),
    );
    _animationText.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
        transform: Matrix4.translationValues(
            _displayList.isAnimationPending ? _animationText.value : 0.0,
            0.0,
            0.0),
        child: Container(
            //duration: Duration(milliseconds: _animationDuration),
            padding: const EdgeInsets.all(12),
            margin: EdgeInsets.fromLTRB(32, 8, 0, 8),
            decoration: BoxDecoration(color: Colors.yellow[100]),
            child: Text(_displayList.contentString,
                style: buildTextSimpleContentBlack(16, Colors.yellow[100]))));
  }
}
