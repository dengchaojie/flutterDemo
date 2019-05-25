import 'package:flutter/material.dart';
import 'package:flutter_douban/model/movie_item.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:flutter_douban/public.dart';
import 'package:cached_network_image/cached_network_image.dart';



class MovieTopItemView extends StatelessWidget {

  final List<MovieItem> movies;
  final String title;
  final String subTitle;
  final PaletteColor coverColor;
  MovieTopItemView(this.movies, this.title, this.subTitle, this.coverColor);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      child: Column(
        children: <Widget>[
          Container(
            child: new Stack(
              children: <Widget>[
                Container(
                  width: Screen.width,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(movies[0].images.medium),
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                  ),

                ),
                Opacity(
                  opacity: 0.6,
                  child: Container(
                    width: Screen.width,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  width: Screen.width,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(subTitle,
                        style: TextStyle(color: Colors.white),

                      ),
                      Text(title,
                        style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),

                      ),

                    ],
                  ),

                ),
              ],
            ),
          ),
          Expanded(
              child: new Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: coverColor == null ? Color(0xff3E454D) : this.coverColor.color,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5))
                ),
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return itemBuilder(context, index);
                    }
                ),
              )),
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {

    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 100,
            child: Text(
              '${index+1}.${movies[index].title}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new StaticRatingBar(size: 10,
                rate: movies[index].rating.average/2,),
              SizedBox(width: 10,),
              Text(
                '${movies[index].rating.average}',
                style: TextStyle(
                    color: AppColor.white, fontSize: 12
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }


}