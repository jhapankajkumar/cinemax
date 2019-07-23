import 'package:cinemax/data/video/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailerList extends StatefulWidget {
  final List<Video> trailers;

  MovieTrailerList(this.trailers);

  @override
  State<StatefulWidget> createState() {
    return _MovieTrailerListState();
  }
}

class _MovieTrailerListState extends State<MovieTrailerList>
    implements YouTubePlayerListener {
  double _currentVideoSecond = 0.0;
  
  FlutterYoutubeViewController _controller;
  
  YoutubePlayerController _playerController;
  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    // _controller.pause();
    // _playerController.pause();
    super.deactivate();
  }
  
  @override
  Widget build(BuildContext context) {
     return Center(child: Text('No Videos available'),);
    
    // buildPlayer(widget.trailers[0].key);
    // return Container(
    //   child: ListView.builder(
    //       scrollDirection: Axis.vertical,
    //       itemCount: 1,
    //       itemBuilder: (context, index) {
    //         return buildPlayer(widget.trailers[index].key);
    //       }),
    // );
  }

  
  Widget buildPlayer(String videoId) {
    return Stack(
      children: <Widget>[
        Container(
            height: 300,
            child: FlutterYoutubeView(
              scaleMode: YoutubeScaleMode.none,
              onViewCreated: _onYoutubeCreated,
              listener: this,
              params:
                  YoutubeParam(videoId: videoId, showUI: true, startSeconds: 0),
            )),
      ],
    );
  }

  void _onYoutubeCreated(FlutterYoutubeViewController controller) {
    this._controller = controller;
  }

  void _loadOrCueVideo() {
    _controller.loadOrCueVideo('gcj2RUWQZ60', _currentVideoSecond);
  }

  @override
  void onCurrentSecond(double second) {
    print('Seconds: $second');
  }

  @override
  void onError(String error) {
    print('ERROR: $error');
  }

  @override
  void onReady() {
    print('ONREADY');
    // this._controller.pause();
  }

  @override
  void onStateChange(String state) {
    print("onStateChange state = $state");
    setState(() {
    });
  }

  @override
  void onVideoDuration(double duration) {
    
  }
}
