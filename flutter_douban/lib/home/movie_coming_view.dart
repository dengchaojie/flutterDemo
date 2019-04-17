import 'package:flutter/material.dart';
import 'package:flutter_douban/model/movie_item.dart';
import 'package:flutter_douban/widget/movie_cover_image.dart';
import 'package:flutter_douban/public.dart';

class MovieComingView extends StatelessWidget {
  final MovieItem movie;

  MovieComingView(this.movie);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    double width = (Screen.width - 15 * 4) / 3;
    return GestureDetector(
      onTap: () {
        AppNavigator.pushMovieDetail(context, movie);
      },
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment:  CrossAxisAlignment.start,
          children: <Widget>[
            MovieCoverImage(movie.images.small, width, width / 0.75),
            SizedBox(height: 5,),
            Text(movie.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
            SizedBox(height: 3,),
            Text('${movie.collectCount}人想看',
              style: TextStyle(fontSize: 10, color: AppColor.grey),
            ),
            SizedBox(height: 3,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 0.5),
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Text(movie.mainlandPubdate.split('-')[1] + '月'
                  + movie.mainlandPubdate.split('-')[2] + '日',
                style: TextStyle(color: Colors.red, fontSize: 8.0),

              ),
            ),
          ],
        ),
      ),
    );
  }



}