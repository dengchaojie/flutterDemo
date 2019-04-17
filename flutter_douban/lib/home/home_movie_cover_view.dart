import 'package:flutter_douban/model/movie_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/widget/movie_cover_image.dart';
import 'package:flutter_douban/public.dart';
import 'package:flutter_douban/app/rate_view.dart';

class HomeMovieCoverView extends StatelessWidget {
  final MovieItem movie;

  HomeMovieCoverView(this.movie);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var width = (Screen.width - 15 * 4 ) / 3;
    return GestureDetector(
      onTap: () {
        AppNavigator.pushMovieDetail(context, movie);
      },
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MovieCoverImage(movie.images.small, width, width / 0.75),
            SizedBox(width: 5,),
            Text(movie.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                new StaticRatingBar(size: 13, rate: movie.rating.average / 2,),
                SizedBox(width: 5,),
                Text(movie.rating.average.toString(), style: TextStyle(color: AppColor.grey, fontSize: 12),),

              ],
            ),

          ],
        ),
      ),
    );
  }


}