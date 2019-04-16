import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';


import 'package:flutter_douban/public.dart';
import 'package:flutter_douban/home/home_scene.dart';
import 'package:flutter_douban/my/my_scene.dart';


class RootScene extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RootSceneState();
  }

}

class RootSceneState extends State<RootScene> {
  int _tabIndex = 0;
  bool isLoaded = false;

  List<Image> _tabImages = [
    Image.asset('images/tab_home.png'),
    Image.asset('images/tab_my.png'),

  ];
  List<Image> _tabSelectedImages = [
    Image.asset('images/tab_home_selected.png'),
    Image.asset('images/tab_my_selected.png'),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupApp();
    
    eventBus.on(EventToggleTabBarIndex, (arg) {
      setState(() {
        _tabIndex = arg;

      });
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    eventBus.off(EventToggleTabBarIndex);

    super.dispose();
  }

  void setupApp() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (!isLoaded) {
      return RefreshProgressIndicator();
    }

    return Scaffold(
      body: IndexedStack(
        children: <Widget>[
          HomeScene(),
          MyScene(),
        ],
        index: _tabIndex,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: AppColor.primary,
        border: Border(top: BorderSide.none),
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: getTabIcon(0),
            title: Text('首页')
          ),
          BottomNavigationBarItem(
              icon: getTabIcon(1),
              title: Text('我的')
          ),
        ],
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );



  }

  Image getTabIcon(int index) {
    if (_tabIndex == index) {
      return _tabSelectedImages[index];
    }else {
      return _tabImages[index];
    }

  }
}

