import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_douban/public.dart';
import 'home_news_banner_view.dart';

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
//    if (nowPlayingList == null) {
//      return Center (
//        child: CupertinoActivityIndicator(),
//      );
//    }else {
      return Container(
        child: RefreshIndicator(
            color: AppColor.primary,
            child: ListView(
              addAutomaticKeepAlives: true,
              cacheExtent: 1000,
              children: <Widget>[
                NewsBannerView(newsList),

              ],
            ),
            onRefresh: fetchData
        ),
      );
//    }

  }

  Future<void> fetchData() async {
    ApiClient client = ApiClient();
    List<MovieNews> movieList = await client.getNewsList();
//    print(movieList);
//    movieList.forEach((movie) {
//      print(movie.title);
//      print(movie.cover);
//      print(movie.link);
//      print(movie.summary);
//    });
    setState(() {
        newsList = movieList;
    });
  }



  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}