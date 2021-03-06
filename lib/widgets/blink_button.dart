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
  Animation<double> _opacity;

  final Color color;
  final String path;
  bool _clicked = false;


  _BlinkButtonState(this.color, this.path);

  @override
  void initializeData() {
    _animationController = new AnimationController(vsync: this,duration: const Duration(milliseconds: 800));
    _opacity = new CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return _buildButton();
    /*if( _clicked ) {
      return _buildButton();
    }
    else {
      return FadeTransition(
        opacity: _opacity,
        child: _buildButton(),
      );
    }*/
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