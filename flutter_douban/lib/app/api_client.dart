import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:flutter_douban/model/movie_news.dart';

class ApiClient {

  static const String baseUrl = 'http://api.douban.com/v2/movie/';
  static const String apiKey = '0b2bdeda43b5688921839c8ecb20399b';
  static const String webUrl = 'https://movie.douban.com/';

  var dio = ApiClient.createDio();
  Future<List<MovieNews>> getNewsList() async {

    List<MovieNews> news = [];

    await http.get(webUrl).then((http.Response response) {
      var document = parse(response.body.toString());
      List<dom.Element> items = document.getElementsByClassName('gallery-frame');
      items.forEach((item) {
        String cover = item.getElementsByTagName('img')[0].attributes['src'].toString();
        String link = item.getElementsByTagName('a')[0].attributes['href'].toString();
        String title = item.getElementsByTagName('h3')[0].text.toString().trim();
        String summary =item.getElementsByTagName('p')[0].text.toString().trim();
        MovieNews movieNews = MovieNews(title, cover, summary, link);
        news.add(movieNews);
      }) ;
    });

    return news;
  }



  Future<dynamic> getNowPlayingList(int start, int count) async {
      Response<Map> response = await dio.get('in_theaters',
          queryParameters: {"start": start, "count": count});
    return response.data['subjects'];
  }

  Future<dynamic> getComingList(int start, int count) async {
    Response<Map> response = await dio.get('coming_soon',
        queryParameters: {"start": start, "count": count});
    return response.data['subjects'];
  }

  Future<dynamic> getSearchListByTag(String tag, int start, int count) async {
    Response<Map> response = await dio.get('search',
        queryParameters: {"tag": tag,"start": start, "count": count});
    return response.data['subjects'];
  }

  Future<dynamic> getActorPhotos(String actorId, int start, int count) async {
    Response<Map> response = await dio.get('celebrity/$actorId/photos',
        queryParameters: {"start": start, "count": count});
    return response.data['photos'];
  }

  Future<dynamic> getMovieAlbum(String movieId, int start, int count) async {
      Response<Map> response = await dio.get('subject/$movieId/photos',
        queryParameters: {"start": start, "count": count});
    return response.data['photos'];
  }

  Future<dynamic> getMovieDetail(String movieId) async {
    Response<Map> response = await dio.get('subject/$movieId');
    return response.data;
  }

  Future<dynamic> getActorDetail(String actorId) async {
    Response<Map> response = await dio.get('celebrity/$actorId');
    return response.data;
  }

  Future<dynamic> getWeeklyList() async {
    Response<Map> response = await dio.get('weekly');
    List content = response.data['subjects'];
    List movies = [];
    content.forEach((item){
      movies.add(item['subject']);
    });
    return movies;
  }

  // 获取新片榜电影
  Future<dynamic> getNewMoviesList() async {
    Response<Map> response = await dio.get('new_movies');
    return response.data['subjects'];
  }

  // 获取北美票房榜电影
  Future<dynamic> getUsBoxList() async {
    Response<Map> response = await dio.get('us_box');
    List content = response.data['subjects'];
    List movies = [];
    content.forEach((item) {
      movies.add(item['subject']);
    });
    return movies;
  }

  // 获取 top250 榜单
  Future<dynamic> getTop250List({int start, int count}) async {
    Response<Map> response = await dio.get('top250', queryParameters: {'start':start, 'count':count});
    return response.data['subjects'];
  }

  static Dio createDio() {
    var options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 100000,
      contentType: ContentType.json,
      queryParameters: {
        "apikey": apiKey
      }


    );
    return Dio(options);

  }

}