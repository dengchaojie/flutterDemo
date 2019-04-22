
import 'package:flutter/material.dart';
import 'package:flutter_douban/util/utility.dart';
import 'package:flutter_douban/public.dart';


class MovieDetailTag extends StatelessWidget {

  final List tags;
  MovieDetailTag(this.tags);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.symmetric(horizontal: 15),

            child: Text('所属频道',
            style: TextStyle(fontSize: fixFontSize(16),
              fontWeight: FontWeight.bold, color: Colors.white,
            ),
            ),
          ),
          SizedBox(height: 10,),
          SizedBox.fromSize(
            size: Size.fromHeight(30),
            child: ListView.builder(itemBuilder: (context, index) {
              return _buildTag(context, index);
            },
              itemCount: tags.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(BuildContext context, int index) {

    String tag = tags[index];
    double paddingRight = 0;
    if (index == tags.length - 1) {
      paddingRight = 15;
    }
    return GestureDetector(
      onTap: () {
        AppNavigator.pushMovieList(context, tag, 'search');
      },
      child: Container(
        margin: EdgeInsets.only(left: 15,right: paddingRight),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Color(0x66000000),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(tag,
              style: TextStyle(fontSize: fixFontSize(14), color: Colors.white),
            ),
            Icon(Icons.keyboard_arrow_right, color: Colors.white,),
          ],
        ),

      ),
    );
  }

}