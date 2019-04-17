import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_douban/public.dart';
import 'home_news_banner_view.dart';
import 'movie_three_grid_view.dart';
import 'package:flutter_douban/util/movie_data_util.dart';


class HomeListView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeListViewState();
  }

}

class HomeListViewState extends State<HomeListView> with AutomaticKeepAliveClientMixin {

  int pageIndex = 0;
  List<MovieNews> newsList;
  var nowPlayingList, comingList;

  @override
  void initState() {
    // TODO: implement initState
    fetchData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (nowPlayingList == null) {
      return Center (
        child: CupertinoActivityIndicator(),
      );
    }else {
      return Container(
        child: RefreshIndicator(
            color: AppColor.primary,
            child: ListView(
              addAutomaticKeepAlives: true,
              cacheExtent: 1000,
              children: <Widget>[
                NewsBannerView(newsList),
                MovieThreeGridView(nowPlayingList, '影院热映', 'in_theaters'),
                MovieThreeGridView(comingList, '即将上映', 'coming_soon'),

              ],
            ),
            onRefresh: fetchData
        ),
      );
    }

  }

  Future<void> fetchData() async {
    ApiClient client = ApiClient();
    List<MovieNews> movieList = await client.getNewsList();
    var moviesNow = await client.getNowPlayingList(0, 6);
    var moviesComing = await client.getComingList(0, 6);

    setState(() {
        newsList = movieList;
        nowPlayingList = MovieDataUtil.getMovieList(moviesNow);
        comingList = MovieDataUtil.getMovieList(moviesComing);
    });
  }



  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}