import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_douban/public.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'movie_top_banner_view.dart';




class MovieTopScrollView extends StatefulWidget {

  final String title;
  MovieTopScrollView(this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MovieTopScrollViewState();
  }


}


class MovieTopScrollViewState extends State<MovieTopScrollView>
    with AutomaticKeepAliveClientMixin<MovieTopScrollView> {


  var weeklyList, topList, usBoxList, newsList;
  List<MovieTopBanner> banners;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  this.widget.title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5,),
                Container(
                  width: 80,
                  height: 2,
                  color: Colors.black,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: MovieTopBannerView(banners),
                ),
                Container(
                  height: 10,
                  color: Color(0xFFF5F5F5),
                ),
              ],
            )
          ),

        ],
      ),

    );
  }

  Future<dynamic> fetchData() async {
    ApiClient client = ApiClient();
    var weeklyList = MovieDataUtil.getMovieList(await client.getWeeklyList());
    var topList = MovieDataUtil.getMovieList(await client.getTop250List());
    var usBoxList = MovieDataUtil.getMovieList(await client.getUsBoxList());
    var newList = MovieDataUtil.getMovieList(await client.getNewMoviesList());
    PaletteGenerator paletteGeneratorWeekly = await
     PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(weeklyList[0].images.small));
    PaletteGenerator paletteGeneratorTop = await
    PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(topList[0].images.small));
    PaletteGenerator paletteGeneratorUsBox = await
    PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(usBoxList[0].images.small));
    PaletteGenerator paletteGeneratorNew = await
    PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(newList[0].images.small));

    setState(() {
      this.weeklyList = weeklyList;
      this.topList = topList;
      this.usBoxList = usBoxList;
      this.newsList = newList;

      banners = [
        new MovieTopBanner(this.weeklyList, '一周口碑电影榜', '每周五更新·共10部',
            'weekly',paletteGeneratorWeekly.darkVibrantColor),
        new MovieTopBanner(this.topList, '豆瓣电影Top250', '豆瓣榜单·共250部',
            'top250',paletteGeneratorTop.darkVibrantColor),
        new MovieTopBanner(this.newsList, '一周新电影榜', '每周五更新·共10部',
            'new_movies',paletteGeneratorNew.darkVibrantColor),
        new MovieTopBanner(this.usBoxList, '北美电影票房榜', '每周五更新·共10部',
            'us_box',paletteGeneratorUsBox.darkVibrantColor)

      ];


    });


  }


  @override
  bool get wantKeepAlive => true;
}

