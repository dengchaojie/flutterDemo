import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';


class MovieVideoPlay extends StatefulWidget {

  final String url;
  MovieVideoPlay(this.url);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MovieVideoPlayState();
  }


}

class MovieVideoPlayState extends State<MovieVideoPlay> {

  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController = VideoPlayerController.network(this.widget.url);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3/2,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,

        ),
        constraints: BoxConstraints.expand(height: MediaQuery.of(context).size.height),
        child: Chewie(
          controller: chewieController,

      ),),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
    chewieController.dispose();
  }

}

