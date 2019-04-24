import 'package:flutter/material.dart';
import 'package:flutter_douban/public.dart';
import 'package:flutter_douban/model/movie_photo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban/widget/movie_photo_preview.dart';
import 'package:flutter/cupertino.dart';
class MoviePhotoList extends StatefulWidget {

  final String action;
  final String movieId;
  final String title;
  MoviePhotoList(this.action, this.movieId, this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MoviePhotoListState();
  }
}

class MoviePhotoListState extends State<MoviePhotoList> {
  int start = 0;
  int count = 24;
  bool _loaded = false;
  List<MoviePhoto> photos;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchData();
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
        brightness: Brightness.light,
        leading: GestureDetector(child:
          Image.asset('images/icon_arrow_back_black.png'),
          onTap: back,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: _buildBody(),

    );
  }

  Widget _buildBody() {
    if (photos == null) {
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }

    double width  = (Screen.width - 2 * 2) / 3;
    List<Widget> children = [];
    List<ImageProvider> providers = [];
    for (int i = 0; i < photos.length; i ++) {
      children.add(GestureDetector(
        onTap: () {
          AppNavigator.push(context, MoviePhotoPreview(providers, i));
        },
        child: Hero(tag: 'photo$i',
            child: Image(
              width: width, height: width, fit: BoxFit.cover,
              image: CachedNetworkImageProvider(photos[i].icon)
            )
        ),

      ));
      providers.add(CachedNetworkImageProvider(photos[i].image));
    }


    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverGrid.count(crossAxisCount: 3,
          mainAxisSpacing: 2, crossAxisSpacing: 2,
          children: children,
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Offstage(
              offstage: _loaded,
              child: CupertinoActivityIndicator(),
            ),
          ),
        ),
      ],
    ) ;
  }

  Future<dynamic> fetchData() async {
    ApiClient client = ApiClient();
    var data;
    String action = this.widget.action;
    if (action == 'actor') {
      data = await client.getActorPhotos(this.widget.movieId, start, count);
    }else if (action == 'movie') {
      data = await client.getMovieAlbum(this.widget.movieId, start, count);

    }
    setState(() {
      if (_loaded) {
        return;
      }
      if(photos == null) {
        photos = [];
      }
      List<MoviePhoto> newPhotos = MovieDataUtil.getPhotoList(data);
      if (newPhotos.length == 0 || newPhotos.length < count) {
        _loaded = true;
      }
      photos.addAll(newPhotos);

      start = start + count;
      count = count + 24;

    });

  }

  void back() {
    Navigator.pop(context);
  }

}