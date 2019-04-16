import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';


class WebViewScene extends StatefulWidget {

  final String url;
  final String title;
  WebViewScene({@required this.url, this.title});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    print(this.url);

    return WebViewSceneState();
  }

}

class WebViewSceneState extends State<WebViewScene> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebviewScaffold(
      url: this.widget.url,
      appBar: AppBar(
        title: Text(this.widget.title ?? ''),
        elevation: 0,
        leading: GestureDetector(
          onTap: back,
          child: Image.asset('images/icon_arrow_back_black.png'),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              Share.share(this.widget.url);
            },
            child: Image.asset('images/icon_menu_share.png'),
          ),
        ],
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: false,
//      initialChild: Container(
//        child: Center(
//          child: CupertinoActivityIndicator(),
//        ),
//      ),
    );
  }

  void back() {
    Navigator.pop(context);
  }
}