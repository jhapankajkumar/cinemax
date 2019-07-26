import 'package:cinemax/data/video/video.dart';
import 'package:flutter/material.dart';


class MovieTrailerList extends StatefulWidget {
  final List<Video> trailers;

  MovieTrailerList(this.trailers);

  @override
  State<StatefulWidget> createState() {
    return _MovieTrailerListState();
  }
}

class _MovieTrailerListState extends State<MovieTrailerList>{
  
  
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

  
  
}
