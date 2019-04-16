import 'package:flutter/material.dart';
import 'app_color.dart';
import 'root_scene.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class AppScene extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'AppScene',
      navigatorObservers: [routeObserver],// only one observer
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        dividerColor: Color(0xFFEEEEEE),
        scaffoldBackgroundColor: AppColor.paper,
        textTheme: TextTheme(
          display1: TextStyle(color: AppColor.darkGrey),
        )
      ),
      home: RootScene(),
    );
  }

}