import 'package:flutter/material.dart';

class MyScene extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MySceneState();
  }
}

class MySceneState extends State<MyScene> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text('MyScene'),
      ),
    );
  }
}