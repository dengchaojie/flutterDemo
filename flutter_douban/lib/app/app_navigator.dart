import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_douban/widget/web_view_scene.dart';


class AppNavigator {


  static pushWeb(BuildContext context, String url, String title) {

    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return WebViewScene(url: url, title: title);
    }));
  }

}