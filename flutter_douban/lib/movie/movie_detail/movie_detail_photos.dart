import 'package:flutter/material.dart';
import 'package:flutter_douban/model/movie_trailer.dart';
import 'package:flutter_douban/model/movie_photo.dart';
import 'package:flutter_douban/util/utility.dart';
import 'package:flutter_douban/public.dart';
import 'package:flutter_douban/widget/movie_video_play.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban/widget/movie_photo_preview.dart';
import 'package:flutter_douban/widget/movie_photo_list.dart';


class MovieDetailPhotos extends StatelessWidget {

  final List<MovieTrailer> trailers;
  final List<MoviePhoto> photos;
  final String id;
  MovieDetailPhotos(this.trailers, this.photos, this.id);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Widget> children = [];
    List<ImageProvider> providers = [];
    Widget showMore() {
      return Container(
        margin: EdgeInsets.only(left: 15, bottom: 15),
        child: GestureDetector(
          onTap: () {
            AppNavigator.push(context, MoviePhotoList('movie', id, '剧照'));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('查看更多', style: TextStyle(color: AppColor.lightGrey,
                fontSize: fixFontSize(12),
              ),
              ),
              Icon(Icons.keyboard_arrow_right, color: AppColor.lightGrey,),
            ],
          ),
        ),

      );

    }

    for (int i = 0; i < trailers.length; i++) {
        children.add(TrailerItem(trailers[i]));
    }

    for (int i = 0; i < photos.length; i++) {
      children.add(PhotoItem(photos[i], i, providers));
      providers.add(CachedNetworkImageProvider(photos[i].image));
    }

    children.add(showMore());

    return Container(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Text('预告片 / 剧照', style: TextStyle(color: Colors.white,
              fontSize: fixFontSize(16), fontWeight: FontWeight.bold,
            ),),
          ),
          SizedBox(height: 10,),
          SizedBox.fromSize(size: Size.fromHeight(120),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: children,
            ),
          )

        ],
      ),
    );


  }


}


class TrailerItem extends StatelessWidget {

  final MovieTrailer trailer;
  TrailerItem(this.trailer);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 15, bottom: 15),
      child: GestureDetector(
        onTap: () {
          AppNavigator.push(context, MovieVideoPlay(trailer.trailerUrl));
        },
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image(image: CachedNetworkImageProvider(this.trailer.cover),
                fit: BoxFit.cover,
                width: 160, height: 120,
              ),
            ),
            Container(
              width: 160, height: 120,
              child: Center(
                child: Opacity(opacity: 0.8,
                  child: Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Icon(Icons.play_arrow, color: Colors.white,),
                    ),
                  )
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}

class PhotoItem extends StatelessWidget {

  final MoviePhoto photo;
  final int index;
  final List<ImageProvider> providers;
  PhotoItem(this.photo, this.index, this.providers);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 15, bottom: 15),
      child: GestureDetector(
        onTap: () {
          AppNavigator.push(context, MoviePhotoPreview(providers, index));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Hero(tag: 'photo$index', child: Image(
              image: CachedNetworkImageProvider(photo.icon),
            width: 160, height: 120, fit: BoxFit.cover,
          ),
          
          ),
          
        ),
      )
    );
  }

}