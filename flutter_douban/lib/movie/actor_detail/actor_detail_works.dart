import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_douban/model/movie_actor_work.dart';
import 'package:flutter_douban/widget/movie_cover_image.dart';
import 'package:flutter_douban/public.dart';


class ActorDetailWorks extends StatelessWidget {

  final List<MovieActorWork> works;
  ActorDetailWorks(this.works);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text('影视作品',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),),
          ),
          SizedBox(height: 20,),
          SizedBox.fromSize(
            size: Size.fromHeight(180),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: works.length,
              itemBuilder: (context, index) {

                return _itemBuilder(context, index);
            },
            ),
          ),


        ],
      ),

    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    MovieActorWork work = works[index];
    double width = 90;
    double paddingRight = 0;
    if (index == works.length -1) {
      paddingRight = 15;
    }
    return GestureDetector(
      onTap: () {
        AppNavigator.pushMovieDetail(context, work.movie);
      },
      child: Container(
        width: width,
        margin: EdgeInsets.only(left: 15, right: paddingRight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MovieCoverImage(work.movie.images.small, width, width / 0.75),
            SizedBox(height: 5,),
            Text(
              work.movie.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,

            ),
            SizedBox(height: 3,),
            Row(
              children: <Widget>[
                new StaticRatingBar(size: 12, rate: work.movie.rating.average/2,),
                SizedBox(height: 5,),
                Text(
                  work.movie.rating.average.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12

                  ),

                ),
              ],
            ),

          ],
        ),
      ),
    );

  }

}