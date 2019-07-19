import 'package:cinemax/data/video/video.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailerList extends StatefulWidget {
  final List<Video> trailers;

  MovieTrailerList(this.trailers);

  @override
  State<StatefulWidget> createState() {
    return _MovieTrailerListState();
  }
}

class _MovieTrailerListState extends State<MovieTrailerList> {
  YoutubePlayerController _controller = YoutubePlayerController();
  String _videoId;
  @override
  void initState() {
    _videoId = widget.trailers[0].key;
    super.initState();
  }

  void listener() {
    if (_controller.value.playerState == PlayerState.ENDED) {
      // _showThankYouDialog();
    }
    setState(() {
      // _playerStatus = _controller.value.playerState.toString();
      // _errorCode = _controller.value.errorCode.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Trailer'),);
    // return Container(
    //   child: Expanded(
    //     flex: 1,
    //       child: ListView.builder(
    //           scrollDirection: Axis.vertical,
    //           itemCount: widget.trailers.length,
    //           itemBuilder: (context, index) {
    //             return _youtubePlayerView(widget.trailers[index].key, context);
    //           })),
    // );
  }

  Widget _youtubePlayerView(String videoId, BuildContext context) {
    return YoutubePlayer(
      context: context,
      videoId: videoId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        forceHideAnnotation: true,
        showVideoProgressIndicator: true,
        disableDragSeek: false,
      ),
      videoProgressIndicatorColor: Color(0xFFFF0000),
      actions: <Widget>[],
      progressColors: ProgressColors(
        playedColor: Color(0xFFFF0000),
        handleColor: Color(0xFFFF4433),
      ),
      onPlayerInitialized: (controller) {
        _controller = controller;
        _controller.addListener(listener);
      },
    );
  }
}
