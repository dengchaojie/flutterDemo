import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban/model/movie_item.dart';
import 'package:flutter_douban/public.dart';
import 'dart:ui' as ui;
import 'movie_top_item.dart';
import 'movie_list_item.dart';
import 'package:flutter/cupertino.dart';

class MovieTopListView extends StatefulWidget {

  final String title;
  final String subTitle;
  final String action;
  MovieTopListView(this.title, this.subTitle, this.action);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MovieTopListViewState();
  }
}

class MovieTopListViewState extends State<MovieTopListView> {
  List<MovieItem> movieList;
  double coverWidth = Screen.width;
  double coverHeight = 218 + Screen.topSafeHeight;
  int start = 0;
  int count = 25;
  bool _loaded = false;
  bool isVisible = true;

  double navAlpha = 0;
  ScrollController scrollController = ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    scrollController.addListener((){
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchData();
      }
      var offset = scrollController.offset;
      if (offset < 0) {
        setState(() {
          navAlpha = 1.0;
        });
      }else if (offset < 50) {
        setState(() {

          navAlpha = 1 - (50 - offset) / 50;
        });
      }else if (navAlpha != 1) {
        setState(() {
          navAlpha = 1;
        });

      }


    });

  }

  Future<void> fetchData() async {
    if (_loaded) {
      return;
    }
    ApiClient client = new ApiClient();
    var data;
    String action = this.widget.action;

    switch (action) {
      case 'weekly':
        data = await client.getWeeklyList();
        break;
      case 'new_movies':
        data = await client.getNewMoviesList();
        break;
      case 'us_box':
        data = await client.getUsBoxList();
        break;
      case 'top250':
        data = await client.getTop250List(start: start, count: count);
        break;
    }

    setState(() {
      if (movieList == null) {
        movieList = [];
      }
      List<MovieItem> newMovies = MovieDataUtil.getMovieList(data);
      newMovies.forEach((movie) {
        movieList.add(movie);
      });
      if(this.widget.action == 'top250') {
        if (newMovies.length == 0) {
          _loaded = true;
          return;
        }
      }else {
        _loaded = true;
        return;
      }

      start = start + count;

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                  child: ListView(
                      children: <Widget>[
                        _buildHeader(),
                        _buildList()
                      ],
                  )

              )
            ],
          ),
          _buildNavigationBar(),

        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    return Stack(

      children: <Widget>[
        Container(
          width: 44,
          height: Screen.navigationBarHeight,
          padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
          child: GestureDetector(
            onTap: back,
            child: Image.asset('images/icon_arrow_back_white.png'),
          ),
        ),
        Opacity(
          opacity: navAlpha,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
            height: Screen.navigationBarHeight,
            child: Row(
              children: <Widget>[
                Container(
                  width: 44,
                  child: GestureDetector(
                    onTap: back,
                    child: Image.asset('images/icon_arrow_back_white.png'),
                  ),
                ),
                Expanded(
                    child: Text(
                         this.widget.title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,

                )
                ),
                Container(
                  width: 44,
                )
              ],
            )
          ),
        ),

      ],
    );

  }

  void back() {
    Navigator.pop(context);
  }

  Widget _buildList() {
    int index = 1;
    List<Widget> children = [];
    for(int i = 0; i < movieList.length; i++ ) {
      children.add(MovieTopItem(index++, MovieListItem(movieList[i], this.widget.action)));
    }
    Widget loading = Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Offstage(
        offstage: _loaded,
        child: CupertinoActivityIndicator(),
      ),
    );
    children.add(loading);
    return Container(
      child: Column(
        children: children,
      ),
    );

  }

  Widget _buildHeader() {
    return Container(
      child: Stack(
        children: <Widget>[
          Image(
              image: CachedNetworkImageProvider(movieList[0].images.large),
              width: coverWidth,
              height: coverHeight,
              fit: BoxFit.fitWidth,

          ),
          Container(
            color: Color(0xbb000000),
            width: coverWidth,
            height: coverHeight,

          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              width: coverWidth,
              height: coverHeight,
              padding: EdgeInsets.fromLTRB(30, 54 + Screen.topSafeHeight, 10, 20),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.widget.subTitle,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    this.widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),

            ),

          ),

        ],
      ),
    );



  }

}