import 'package:flutter/material.dart';
import 'package:flutter_douban/public.dart';
import 'home_list_view.dart';

class HomeScene extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeSceneState();
  }
}

class HomeSceneState extends State<HomeScene> {
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text('首页'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),
              onPressed: () => showSearch(context: context, delegate: SearchBarDelegate()),
          ),
        ],
      ),
      body: HomeListView(),
    );
  }


}