import 'package:flutter_douban/model/movie_item.dart';
import 'package:flutter_douban/model/movie_photo.dart';

class MovieDataUtil {
  static List<MovieItem> getMovieList(List list) {

    List<MovieItem> movies = [];
    list.forEach((data) {
      MovieItem item = MovieItem.fromJson(data);
      movies.add(item);
    });
    return movies;
  }

  static List<MoviePhoto> getPhotoList(List list) {
    List<MoviePhoto> photos = [];
    list.forEach((item) {
      photos.add(MoviePhoto.fromJson(item));
    });

    return photos;

  }


}