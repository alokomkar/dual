import 'package:dual_mode/base/base_state.dart';
import 'package:flutter/material.dart';

class BlinkButton extends StatefulWidget {
  final Color color;
  final String path;


  BlinkButton(this.color, this.path);

  @override
  _BlinkButtonState createState() {
    return _BlinkButtonState(this.color, this.path);
  }
}

class _BlinkButtonState extends BaseState<BlinkButton> with SingleTickerProviderStateMixin {

  AnimationController _animationController;

  final Color color;
  final String path;
  bool _clicked = false;


  _BlinkButtonState(this.color, this.path);

  @override
  void initializeData() {
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    if( _clicked ) {
      return _buildButton();
    }
    else {
      return FadeTransition(
        opacity: _animationController,
        child: _buildButton(),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _buildButton() => Padding(
    padding: EdgeInsets.all(4),
    child: GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(path);
        _animationController.stop(canceled: true);
        setState(() {
          _clicked = true;
        });
      },
      child : Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container( color: color, height: 5, width: 140,),
              CircleAvatar(
                child: Text("?", style: buildTextStyle(16)),
                radius: 28,
                //foregroundColor: color,
                backgroundColor: color,
              ),
              Container( color: color, height: 5, width: 140,),
            ],
          ),
        ),
      ),
    ),
  );


}