import 'package:flutter/material.dart';

class MovieListView extends StatefulWidget {

  final String title;
  final String action;
  MovieListView(this.title, this.action);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MovieListViewState();
  }

}

class MovieListViewState extends State<MovieListView> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text('等待完成'),
      ),
    );
  }
}
