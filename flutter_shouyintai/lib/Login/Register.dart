import 'package:flutter/material.dart';

class RegisterVC extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterVCState();
  }
}

class RegisterVCState extends State<RegisterVC> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('注册'),
      ),
      body: ListView(
        children: <Widget>[
          Text('RegisterVC'),
        ],
      ),
    );
  }
}