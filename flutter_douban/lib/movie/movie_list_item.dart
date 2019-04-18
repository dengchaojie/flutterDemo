import 'package:flutter/material.dart';
import 'package:flutter_douban/model/movie_item.dart';
import 'package:flutter_douban/app/app_navigator.dart';
import 'package:flutter_douban/widget/movie_cover_image.dart';
import 'package:flutter_douban/public.dart';
import 'package:flutter_douban/model/movie_actor.dart';
//import 'm';

class MovieListItem extends StatelessWidget {

  final MovieItem movie;
  final String action;
  MovieListItem(this.movie, this.action);

  Widget _getActionWidget() {

    if (action == 'coming_soon') {
      String update = '';
      if(movie.mainlandPubdate == '') {
          update = '待定';
      }else {
          update = movie.mainlandPubdate.split('-')[1] + '月\n' +
              movie.mainlandPubdate.split('-')[2] + '日';
      }

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 0.5),
          borderRadius: BorderRadius.circular(2),

        ),
        child: Text(update, style: TextStyle(color: Colors.red, fontSize: 12),),
      );

    }else if (action == 'in_theaters' || action == 'search') {

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(icon: Icon(Icons.favorite_border),
            onPressed: () {

            },
            color: Color(0xFFF7AC3A),
          ),
          Text('收藏', style: TextStyle(color: Color(0xFFF7AC3A)),),
        ],
      );
    }else {
      print('_getActionWidget未定义');
      return Container();

    }

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double imgWidth = 100;
    double height = imgWidth / 0.75;
    double spaceWidth = 15;
    double actionWidth = 60;


    return GestureDetector(
      onTap: () {
        AppNavigator.pushMovieDetail(context, movie);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(spaceWidth, spaceWidth, 0, spaceWidth),
        decoration: BoxDecoration(
          color: Colors.white,
          border: BorderDirectional(bottom: BorderSide(color: Colors.grey, width: 0.5)),
        ),
        child: Row(
          children: <Widget>[
            MovieCoverImage(movie.images.small, imgWidth, height),
            Container(
              padding: EdgeInsets.fromLTRB(spaceWidth, 0, spaceWidth, 0),
              height: height,
              width: (Screen.width - imgWidth - spaceWidth * 2 - actionWidth) ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(movie.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new StaticRatingBar(size: 13, rate: movie.rating.average / 2,
                      ),
                      SizedBox(width: 5,),
                      Text(movie.rating.average.toString(),
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(
                    '${movie.year} /${genres2String(movie.genres)}/'
                        '${actor2String(movie.directors)}/${actor2String(movie.casts)}',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )

                ],
              ),
            ),
            Container(
              width: actionWidth,
              height: height,
              child: Center(child: _getActionWidget(),),
            )


          ],

        ),

      ),
    );


  }

  String genres2String(List genres) {

    StringBuffer sb = new StringBuffer();
    genres.forEach( (one) {

      sb.write(' $one ');
    });
    return sb.toString();
  }

  String actor2String(List<MovieActor> actors) {

    String names = ' ';
    actors.forEach( (actor) {

      names = names + actor.name + ' ';
    });
    return names;
  }

}

