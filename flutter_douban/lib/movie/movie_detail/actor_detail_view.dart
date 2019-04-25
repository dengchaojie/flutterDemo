import 'package:flutter/material.dart';
import 'package:flutter_douban/public.dart';
//import 'package:flutter_douban/model/movie_actor.dart';
import 'package:flutter_douban/model/movie_actor_detail.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_douban/movie/actor_detail/actor_detail_header.dart';
import 'package:flutter_douban/movie/actor_detail/actor_detail_summary.dart';
import 'package:flutter_douban/movie/actor_detail/actor_detail_works.dart';
import 'package:flutter_douban/movie/actor_detail/actor_detail_photo.dart';

class ActorDetailView extends StatefulWidget {

  final String id;
  ActorDetailView(this.id);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ActorDetailViewState();
  }


}

class ActorDetailViewState extends State<ActorDetailView> {

  MovieActorDetail actorDetail;
  Color pageColor;
  ScrollController scrollController = ScrollController();
  double navAlpha = 0;
  bool isSummaryUnfold = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();

    scrollController.addListener(() {
      double offset = scrollController.offset;
      if (offset < 0) {
        if (navAlpha != 0) {
          setState(() {
            navAlpha = 0;
          });
        }

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
    Screen.updateStatusBarStyle(SystemUiOverlayStyle.light);
    if (actorDetail == null) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: back,
            child: Image.asset('images/icon_arrow_back_black.png'),
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
                  controller: scrollController,
                  padding: EdgeInsets.only(top: 0),
                  children: <Widget>[
                    ActorDetailHeader(actorDetail, pageColor),
                    ActorDetailSummary(actorDetail, isSummaryUnfold,
                        changeIsUnfold),
                    ActorDetailWorks(actorDetail.works),
                    ActorDetailPhoto(actorDetail.photos, actorDetail.id),


                  ],
                )),

              ],
            ),
          ),
          _buildNav(),
        ],
      ),

    );
  }

  void changeIsUnfold() {
    setState(() {
      isSummaryUnfold = !isSummaryUnfold;

    });
  }

  Widget _buildNav() {
    return Stack(
      children: <Widget>[
        Container(
          width: 44,
          height: Screen.navigationBarHeight,
          padding: EdgeInsets.only(left: 5, top: Screen.topSafeHeight,
            right: 0, bottom: 0),
          child: GestureDetector(
            child: Image.asset('images/icon_arrow_back_white.png'),
            onTap: back,
          ),
        ),
        Opacity(opacity: navAlpha,
          child: Container(
            height: Screen.navigationBarHeight,
            padding: EdgeInsets.only(left: 5, top: Screen.topSafeHeight,
              right: 0, bottom: 0),
            decoration: BoxDecoration(color: pageColor),
            child: Row(
              children: <Widget>[
                Container(
                  width: 44,
                  child: GestureDetector(
                    onTap: back, child: Image.asset('images/icon_arrow_back_white.png'),
                  ),
                ),
                Expanded(child: Text(actorDetail.name, style: TextStyle(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold,
                ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 44,
                ),
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
    MovieActorDetail detail = MovieActorDetail.fromJson(
        await client.getActorDetail(this.widget.id));
    PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(detail.avatars.small));

    setState(() {
      actorDetail = detail;
      if (generator.darkMutedColor == null) {
        pageColor = Color(0xff35374c);
      }else {
        pageColor = generator.darkMutedColor.color;
      }
    });
  }
}