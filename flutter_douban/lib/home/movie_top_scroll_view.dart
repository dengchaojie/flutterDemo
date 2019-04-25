import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MovieTopScrollView extends StatefulWidget {

  final String title;
  MovieTopScrollView(this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MovieTopScrollViewState();
  }


}


class MovieTopScrollViewState extends State<MovieTopScrollView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

  Future<dynamic> fetchData() async {


  }

}