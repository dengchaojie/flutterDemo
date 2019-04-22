import 'package:flutter/material.dart';
import 'package:flutter_douban/model/movie_actor.dart';
import 'package:flutter_douban/util/utility.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban/public.dart';
import 'actor_detail_view.dart';




class MovieDetailCastView extends StatelessWidget {

  final List<MovieActor> directors;
  final List<MovieActor> casts;
  MovieDetailCastView(this.directors, this.casts);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text('演职员', style: TextStyle(color: Colors.white,
                fontSize: fixFontSize(16), fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 10,),
          SizedBox.fromSize(size: Size.fromHeight(130),
            child: ListView.builder(itemBuilder: (context, index) {
              return _buildCastView(context, index);

            },
              itemCount: directors.length + casts.length,
              scrollDirection: Axis.horizontal,

            ),
          ),

        ],
      ),
    );
  }

  Widget _buildCastView(BuildContext context , int index) {

    MovieActor cast;
    if (index < directors.length) {
      cast  = directors[index];

    }else {
      int newIndex = index - directors.length;
      cast  = casts[newIndex];

    }
    double paddingRight = 0;
    if (index == directors.length + casts.length - 1) {
      paddingRight = 15;
    }

    return Container(
      margin: EdgeInsets.only(left: 15, right: paddingRight),
      child: Column(

        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (cast.id == null) {
                Toast.show('暂无演员信息');

              }else {
                AppNavigator.push(context, ActorDetailView(cast.id));

              }
            },
            child: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(cast.avatars.large),
              radius: 40,
            ),
          ),
          Container(
            width: 80,
            child: Center(
              child: Text(cast.name, style: TextStyle(color: Colors.white,
                  fontSize: fixFontSize(14)),
                maxLines: 1, overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

        ],
      ),
    );
  }


}