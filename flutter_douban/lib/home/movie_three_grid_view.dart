import 'package:flutter/material.dart';
import 'package:flutter_douban/model/movie_item.dart';
import 'home_movie_cover_view.dart';
import 'movie_coming_view.dart';

class MovieThreeGridView extends StatelessWidget {
  final List<MovieItem> movies;
  final String title;
  final String action;
  MovieThreeGridView(this.movies, this.title, this.action);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Column(

        children: <Widget>[
          HomeMovieCoverView(movies),
          MovieComingView(movies),

        ],
      ),
    );
  }
}
