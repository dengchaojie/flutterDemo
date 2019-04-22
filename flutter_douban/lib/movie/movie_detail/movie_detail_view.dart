import 'package:flutter/material.dart';
import 'package:flutter_douban/model/movie_item.dart';
import 'package:flutter_douban/public.dart';
import 'package:flutter_douban/model/movie_detail.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'movie_detail_header.dart';
import 'package:flutter/cupertino.dart';
import 'movie_detail_tag.dart';
import 'movie_summary_view.dart';
import 'movie_detail_cast_view.dart';
import 'movie_detail_photos.dart';
import 'movie_detail_comment.dart';

class MovieDetailView extends StatefulWidget {

  final MovieItem movie;
  MovieDetailView(this.movie);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MovieDetailViewState();
  }


}

class MovieDetailViewState extends State<MovieDetailView> {
  MovieDetail movieDetail;

  double navAlpha = 0;
  Color pageColor;
  ScrollController _scrollController = ScrollController();
  bool isSummaryUnfold = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
    _scrollController.addListener(() {

      double offset = _scrollController.offset;
      if (offset < 0) {
        setState(() {
          navAlpha = 0;

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(movieDetail == null) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: back,
            child: Image.asset('images/icon_arrow_back_white.png'),
          ),
        ),
        body: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }
    
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: pageColor,
            child: Column(
              children: <Widget>[
                Expanded(child: ListView(
                  controller: _scrollController,
                  padding: EdgeInsets.only(top: 0),
                  children: <Widget>[
                    MovieDetailHeader(movieDetail, pageColor),
                    MovieDetailTag(movieDetail.tags),
                    MovieSummaryView(movieDetail.summary, isSummaryUnfold,
                        changeSummaryUnfold),
                    MovieDetailCastView(movieDetail.directors, movieDetail.casts),
                    MovieDetailPhotos(movieDetail.trailers, movieDetail.photos,
                        movieDetail.id),
                    MovieDetailComment(movieDetail.comments),



                  ],
                )

                ),

              ],
            ),

          ),
          buildNavigationBar(),
        ],
      ),
    );
  }


  void changeSummaryUnfold() {

    setState(() {
      isSummaryUnfold = !isSummaryUnfold;
    });
  }


  Widget buildNavigationBar() {
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
        Opacity(opacity: navAlpha,
          child: Container(
            decoration: BoxDecoration(color: pageColor),
            height: Screen.navigationBarHeight,
            padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 44,
                  child: GestureDetector(onTap: back,
                         child: Image.asset('images/icon_arrow_back_white.png'),

                  ),
                ),
                Expanded(child: Text(this.widget.movie.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                        color: Colors.white,),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),

                ),
                Container(width: 44,),

              ],
            ),
          ),


        ),
      ],

    );
  }

  void back() {
    Navigator.pop(context);
  }

  Future<dynamic> fetchData() async {
    ApiClient client = ApiClient();
    MovieDetail detail = MovieDetail.fromJson(await client.getMovieDetail(this.widget.movie.id));
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(CachedNetworkImageProvider(detail.images.small));

    setState(() {
      if (paletteGenerator.darkVibrantColor == null) {
        pageColor = Color(0xff35374c);
      }else {
        pageColor = paletteGenerator.darkVibrantColor.color;
      }
      movieDetail = detail;
    });



  }

}

