import 'package:cinemax/data/video/video.dart';
import 'package:cinemax/services/movie/movie_services.dart';
import 'package:cinemax/util/constant.dart';
import 'package:cinemax/util/utility_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';


class YoutubeDefaultWidget extends StatefulWidget {
  
  final int movieId;
  const YoutubeDefaultWidget(this.movieId);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<YoutubeDefaultWidget>
    implements YouTubePlayerListener {

  List<Video> videoList;
  FlutterYoutubeViewController _controller;
  APIStatus status ;

  @override
  void initState() {
    if (widget.movieId != null){
      status = APIStatus.InProcess;
      _getVideoList(widget.movieId);
    }
    
    super.initState();
  }

  @override
  void deactivate() {
    if(_controller != null){
      _controller.pause();
    }
    
    super.deactivate();
  }

  
  Widget noRecordContainer(){
    return Center(child: Text('No Record found', style:titleStyle),);
  }
  _getVideoList(int movieId) async {
    await MovieServices().fetchVideoList(movieId).then((videos) {
      setState(() {
        status = APIStatus.Success;
        videoList = videos.results;
      });
    }).catchError((onError) {
        setState(() {
          status = APIStatus.Failed;
        });
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Video', style:titleStyle),
        ),
        body: status == APIStatus.InProcess ?  loadingIndicator() :
        (status == APIStatus.Failed ?  noRecordContainer() :
        Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                child: FlutterYoutubeView(
              onViewCreated: _onYoutubeCreated,
              listener: this,
              params: YoutubeParam(
                  videoId: videoList[0].key, showUI: true, startSeconds: 0 * 60.0),
            )),
          ],
        )));
  }

  @override
  void onCurrentSecond(double second) {
    print("onCurrentSecond second = $second");
    // _currentVideoSecond = second;
  }

  @override
  void onError(String error) {
    print("onError error = $error");
  }

  @override
  void onReady() {
    // _controller.pause();
    print("onReady");
  }

  @override
  void onStateChange(String state) {
    print("onStateChange state = $state");
    
  }

  @override
  void onVideoDuration(double duration) {
    print("onVideoDuration duration = $duration");
  }

  void _onYoutubeCreated(FlutterYoutubeViewController controller) {
    this._controller = controller;
  }
}