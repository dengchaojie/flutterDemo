import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_douban/model/movie_actor_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban/public.dart';
import 'dart:ui' as ui;

class ActorDetailHeader extends StatelessWidget {

  final MovieActorDetail actorDetail;
  final Color pageColor;
  ActorDetailHeader(this.actorDetail, this.pageColor);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    double height = Screen.topSafeHeight + 218;
    return Container(
      width: Screen.width,
      height: height,
      child: Stack(
        children: <Widget>[
          Image(image: CachedNetworkImageProvider(
              actorDetail.photos == null ? actorDetail.avatars.large
                  : actorDetail.photos[0].image),
            width: Screen.width, height: height,
            fit: BoxFit.cover,
          ),
          Opacity(opacity: 0.7, child: Container(color: pageColor,
            width: Screen.width, height: height,
          ),),
          BackdropFilter(filter: ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              width: Screen.width, height: height,
              color: Colors.transparent,
              padding: EdgeInsets.fromLTRB(30, 54+Screen.topSafeHeight, 10, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage:
                      CachedNetworkImageProvider(actorDetail.avatars.large),
                    radius: 50,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    actorDetail.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                ],
              ),
            ),
          ),



        ],
      ),
    );
  }
}