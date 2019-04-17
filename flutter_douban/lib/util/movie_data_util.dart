import 'package:flutter_douban/model/movie_item.dart';


class MovieDataUtil {
  static List<MovieItem> getMovieList(List list) {

    List<MovieItem> movies = [];
    list.forEach((data) {
      MovieItem item = MovieItem.fromJson(data);
      movies.add(item);
    });
    return movies;
  }



}