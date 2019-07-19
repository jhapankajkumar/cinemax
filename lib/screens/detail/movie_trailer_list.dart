import 'package:cinemax/data/video/video.dart';
import 'package:flutter/material.dart';

class MovieTrailerList extends StatelessWidget {

 final List<Video> trailers;

  const MovieTrailerList({Key key, this.trailers}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Trailer"),);
  }
}

