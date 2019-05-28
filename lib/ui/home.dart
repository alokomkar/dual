import 'package:dual_mode/base/base_state.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => HomeState();

}

class HomeState extends BaseState<HomeScreen> {
  @override
  Widget build(BuildContext context) =>  new Scaffold(
      body : new Center( child : new Text("Coding here", textAlign: TextAlign.center,),));
}