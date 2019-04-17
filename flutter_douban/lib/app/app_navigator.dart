import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_douban/widget/web_view_scene.dart';
import 'package:flutter_douban/movie/movie_list_view.dart';
import 'package:flutter_douban/model/movie_item.dart';
import 'package:flutter_douban/movie/movie_detail_view.dart';



class AppNavigator {

  static push(BuildContext context, Widget scene) {
    Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => scene));
  }



  static pushMovieDetail(BuildContext context, MovieItem movie) {
    AppNavigator.push(context, MovieDetailView(movie));
  }

  static pushMovieList(BuildContext context, String title, String action) {
      AppNavigator.push(context, MovieListView(title, action));
  }

  static pushWeb(BuildContext context, String url, String title) {

    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return WebViewScene(url: url, title: title);
    }));
  }

}