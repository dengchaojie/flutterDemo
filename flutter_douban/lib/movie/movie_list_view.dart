import 'package:flutter/material.dart';
import 'package:flutter_douban/model/movie_item.dart';
import 'package:flutter/cupertino.dart';
import 'movie_list_item.dart';
import 'package:flutter_douban/app/api_client.dart';
import 'package:flutter_douban/util/movie_data_util.dart';



class MovieListView extends StatefulWidget {

  final String title;
  final String action;
  MovieListView(this.title, this.action);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MovieListViewState(this.title, this.action);
  }

}

class MovieListViewState extends State<MovieListView> {
  final String title;
  final String action;
  MovieListViewState(this.title, this.action);

  bool isLoaded = false;
  int start = 0, count = 20;

  List<MovieItem> movies = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
    _scrollController.addListener( () {
      if (_scrollController.position.pixels
          == _scrollController.position.maxScrollExtent) {
        fetchData();
      }

    });

  }

  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title + '电影'),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: back,
          child: Image.asset('images/icon_arrow_back_black.png')
        ),


      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (movies.length == 0) {
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }

    return Container(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          if (index + 1 == movies.length) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Center(

                child: Offstage(
                  offstage: isLoaded,
                  child: CupertinoActivityIndicator(),
                ),
              ),
            );
          }
          return MovieListItem(movies[index], action);
        },
      ),
    );
  }

  void back() {
    Navigator.pop(context);
  }

  Future<void> fetchData() async {
    if (isLoaded) {
      return;
    }
    ApiClient client = new ApiClient();
    var movieList;
    if(action == 'in_theaters') {

      movieList = await client.getNowPlayingList(start, count);

    }else if(action == 'coming_soon')  {

      movieList = await client.getComingList(start, count);

    }else if(action == 'search')  {

      movieList = await client.getSearchListByTag(title, start, count);

    }else {
      print('未匹配');
    }


    setState(() {

      if(movieList == null) {
        print('movieList == null');
        isLoaded = true;
        return;
      }
      if (movieList.length == 0) {
        print('movieList.length == 0');
        isLoaded = true;
        return;
      }
      movies = MovieDataUtil.getMovieList(movieList);

//      print(movies);

      start = start + count;

    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _scrollController.dispose();
  }


}
