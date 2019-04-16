import 'package:flutter/material.dart';
import 'package:flutter_douban/public.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

class NewsBannerView extends StatelessWidget {
  final List<MovieNews> banners;
  NewsBannerView(this.banners);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (banners == null) {
      return Container(
        width: Screen.width,
        height: 100,
      );
    }
    return Container(
      color: Colors.white,
      child: CarouselSlider(
          items: banners.map((banner) {
            return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      print(banner.link);
                      AppNavigator.pushWeb(context, banner.link, banner.title);
                    },
                    child: Container(
                      width: Screen.width,
                      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: Screen.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(banner.cover),
                                  fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(3)),
                            )
                          ),
                          Opacity(
                            opacity: 0.5,
                            child: Container(
                              width: Screen.width,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.all(Radius.circular(3)),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20.0),
                            width: Screen.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(banner.title,
                                  style: TextStyle(
                                    color: AppColor.white,
                                    fontSize: 16,
                                    fontWeight:FontWeight.bold,
                                  ),
                                ),
                                Text(banner.summary,
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ],

                            ),
                          ),
                        ],
                      ),
                    ),

                  );


            });
          }).toList(),
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          enlargeCenterPage: true,
          aspectRatio: 2,
      ),
    );
  }





}

class NewsBanner {
  MovieNews news;

  NewsBanner(this.news);

}