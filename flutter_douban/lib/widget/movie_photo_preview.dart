import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:flutter/cupertino.dart';
class MoviePhotoPreview extends StatefulWidget {
  final List<ImageProvider> providers;
  final int index;
  final PageController pageController;
  MoviePhotoPreview(this.providers, this.index) :
        pageController = PageController(initialPage: index);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MoviePhotoPreviewState();
  }

}

class MoviePhotoPreviewState extends State<MoviePhotoPreview> {

  int currentIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = this.widget.index;

  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;

    });
  }

  void back() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<PhotoViewGalleryPageOptions> options = [];
    for (int i = 0; i < this.widget.providers.length; i++) {
      options.add(PhotoViewGalleryPageOptions(
          imageProvider: this.widget.providers[i], heroTag: 'photo$i'));
    }


    return  Scaffold(
//      appBar: AppBar(
//        leading: IconButton(icon:
//          Icon(Icons.backup), onPressed: back, color: Colors.white,),
//      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        constraints: BoxConstraints.expand(height: MediaQuery.of(context).size.height),
        child: Stack(
          alignment: Alignment.bottomRight,

          children: <Widget>[
            PhotoViewGallery(
              pageOptions: options,
              scrollPhysics: const BouncingScrollPhysics(),
              pageController: this.widget.pageController,
              onPageChanged: onPageChanged,
              loadingChild: CupertinoActivityIndicator(),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text('${currentIndex + 1} / ${this.widget.providers.length}',
                style: TextStyle(color: Colors.white, fontSize: 16,decoration: null),
              ),
            )

          ],
        ),

      ),

    );
  }

}