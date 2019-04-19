import 'package:flutter/material.dart';
import 'package:flutter_douban/model/movie_detail.dart';
import 'package:flutter_douban/public.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban/widget/movie_cover_image.dart';
import 'package:flutter_douban/util/utility.dart';
import 'package:flutter_douban/model/movie_actor.dart';

class MovieDetailHeader extends StatelessWidget {

  final MovieDetail movieDetail;
  final Color pageColor;
  MovieDetailHeader(this.movieDetail, this.pageColor);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = Screen.width;
    double height = 218 + Screen.topSafeHeight;

    return Container(
      child: Stack(
        children: <Widget>[
          Image(image: CachedNetworkImageProvider(movieDetail.photos[0].image),
              width: width,height: height,
              fit: BoxFit.cover,

          ),
          Opacity(opacity: 0.7,
            child: Container(width: width, height: height, color: pageColor,),
          ),
          Container(
            width: width, height: height,
            color: Colors.transparent,
            padding: EdgeInsets.fromLTRB(15, 54+Screen.topSafeHeight, 10, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Color(0x66000000),
                      offset: Offset(1, 1),
                      blurRadius: 5.0,
                      spreadRadius: 2
                    ),
                  ],
                  ),

                  child: MovieCoverImage(movieDetail.images.small, 100, 133),
                ),
                SizedBox(width: 15,),
                Expanded(child: Column(
                  children: <Widget>[
                    Text(movieDetail.title, style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: fixFontSize(20),
                      color: Colors.white,
                    ),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5,),
                    Text(movieDetail.title + '(${movieDetail.year})',
                      style: TextStyle(color: Colors.white, fontSize: fixFontSize(16),
                        fontWeight: FontWeight.bold
                      ),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        StaticRatingBar(rate: movieDetail.rating.average / 2, size: 13,),
                        SizedBox(width: 3,),
                        Text(movieDetail.rating.average.toString(), 
                          style: TextStyle(color: Colors.white, fontSize: fixFontSize(12)),)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text('${countries2String(movieDetail.countries)}/${list2String(movieDetail.genres)}/ '
                        '上映时间：${list2String(movieDetail.pubdates)}/ '
                        '片长：${list2String(movieDetail.durations)}/${actor2String(movieDetail.directors)}/${actor2String(movieDetail.casts)}',
                      style: TextStyle(
                          color: AppColor.white,
                          fontSize: fixFontSize(12)
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )),


              ],


            ),
          ),

        ],
      ),
    );
  }

}


String actor2String(List<MovieActor> actors) {
  StringBuffer sb = new StringBuffer();
  actors.forEach((actor) {
    sb.write(' ${actor.name} ');
  });
  return sb.toString();
}

String list2String(List list) {
  StringBuffer sb = new StringBuffer();
  list.forEach((item) {
    sb.write(' $item ');
  });
  return sb.toString();
}

String countries2String(List countries) {
  StringBuffer sb = new StringBuffer();
  countries.forEach((country) {
    sb.write('$country ');
  });
  return sb.toString();
}