import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_douban/model/movie_actor_detail.dart';


class ActorDetailSummary extends StatelessWidget {

  final MovieActorDetail actorDetail;
  final bool isSummaryUnfold;
  final VoidCallback onPressed;

  ActorDetailSummary(this.actorDetail, this.isSummaryUnfold, this.onPressed);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('简介',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
          ),),
          SizedBox(height: 15,),
          Text(
            actorDetail.summary,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            maxLines: isSummaryUnfold ? null : 4,
            overflow: TextOverflow.clip,
          ),
          SizedBox(height: 5,),
          GestureDetector(
            onTap: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(isSummaryUnfold ? '收起' : '显示全部',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14),
                ),
                Icon(isSummaryUnfold ? Icons.keyboard_arrow_up :
                  Icons.keyboard_arrow_down, color: Colors.white,)
              ],
            ),
          ),
        ],
      ),
    );
  }

}