import 'package:flutter/material.dart';
import 'package:flutter_douban/util/utility.dart';
import 'package:flutter_douban/public.dart';

class MovieSummaryView extends StatelessWidget {


  final String summary;
  final bool isSummaryUnfold;
  final VoidCallback onPress;
  MovieSummaryView(this.summary, this.isSummaryUnfold, this.onPress);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('简介', style: TextStyle(fontSize: fixFontSize(16),
              color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10,),
          Text(summary, style: TextStyle(fontSize: fixFontSize(14),
              color: Colors.white),
            maxLines: isSummaryUnfold ? null : 4,
            overflow: TextOverflow.clip,
          ),
          SizedBox(height: 5,),
          GestureDetector(
            onTap: onPress,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(isSummaryUnfold ? '收起' : '显示全部', style:
                TextStyle(fontSize: fixFontSize(14), color: Colors.white),
                ),
                Icon(isSummaryUnfold ? Icons.keyboard_arrow_up :
                Icons.keyboard_arrow_down, color: Colors.white,),
              ],
            ),
          ),
        ],
      ),
    );
  }

}