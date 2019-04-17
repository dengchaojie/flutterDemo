import 'package:flutter/material.dart';
import 'package:flutter_douban/model/movie_item.dart';


class MovieDetailView extends StatefulWidget {

  final MovieItem movie;
  MovieDetailView(this.movie);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MovieDetailViewState();
  }


}

class MovieDetailViewState extends State<MovieDetailView> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('MovieDetailView'),
      ) ,
    );
  }


}

