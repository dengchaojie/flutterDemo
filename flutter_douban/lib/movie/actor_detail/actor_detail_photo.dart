import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_douban/model/movie_photo.dart';
import 'package:flutter_douban/public.dart';
import 'package:flutter_douban/widget/movie_photo_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban/widget/movie_photo_list.dart';

class ActorDetailPhoto extends StatelessWidget {

  final List<MoviePhoto> photos;
  final String actorDetailId;
  ActorDetailPhoto(this.photos, this.actorDetailId);



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Widget> children = [];
    List<ImageProvider> providers = [];
    for (int i = 0; i < photos.length; i++) {
      children.add(PhotoItem(photos[i], i, providers));
      providers.add(CachedNetworkImageProvider(photos[i].image));

    }
    Widget showMore = Container(
      margin: EdgeInsets.only(left: 15, bottom: 15),
      child: GestureDetector(
        onTap: () {
          AppNavigator.push(context, MoviePhotoList('actor',
              actorDetailId, '相册'));
        },
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('查看更多',
                style: TextStyle(color: AppColor.lightGrey, fontSize: 12),
              ),
              Icon(Icons.keyboard_arrow_right, color: AppColor.lightGrey,)

            ],
      )
      ),
    );
    children.add(showMore);


    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text('相册',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),
          ),
          SizedBox(height: 10,),
          SizedBox.fromSize(
            size: Size.fromHeight(120),
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: children,

            ),
          ),

        ],
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
    return  Container(
      margin: EdgeInsets.only(left: 15, bottom: 15),
      child: GestureDetector(
        onTap: () {
          AppNavigator.push(context, MoviePhotoPreview(providers, index));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Hero(
            tag: 'photo$index',
            child: Image(
              width: 160,
              height: 120,
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(photo.icon),),

          ),
        ),
      ),

    );
  }
}