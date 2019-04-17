import 'package:flutter/material.dart';
import 'package:flutter_douban/model/movie_item.dart';
import 'home_movie_cover_view.dart';
import 'movie_coming_view.dart';
import 'home_section_view.dart';



class MovieThreeGridView extends StatelessWidget {
  final List<MovieItem> movies;
  final String title;
  final String action;
  MovieThreeGridView(this.movies, this.title, this.action);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var children;
    if (title == '影院热映') {
        children = movies.map((movie) =>
            HomeMovieCoverView(movie)).toList();

    }else if (title == '即将上映') {
        children = movies.map((movie) => MovieComingView(movie)).toList();

    }

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          HomeSectionView(title, action),
          Container(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Wrap(spacing: 15, runSpacing: 20, children: children,),
          ),
          Container(
            height: 10,
            color: Color(0xFFF5F5F5),
          ),

        ],
      ),
    );
  }
}
