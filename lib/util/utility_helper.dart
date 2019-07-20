import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

Widget loadingIndicator() {
  Widget indicator;
  if (Platform.isAndroid) {
    indicator =  Center(
      child: CircularProgressIndicator(),
    );
  } else if (Platform.isIOS) {
    indicator =  Center(
      child: CupertinoActivityIndicator(),
    );
  }
  return indicator;
}

enum MovieListType {
  NowPaying,
  Upcoming,
  Popular,
  Trending,
  TopRated,
}

String getTextForEnum(MovieListType type) {
  switch (type) {
    case MovieListType.NowPaying:
      return 'NOW PLAYING';
      break;
    case MovieListType.Upcoming:
      return 'UPCOMING';
      break;
    case MovieListType.Popular:
      return 'POPULAR';
      break;
    case MovieListType.Trending:
      return 'TRENDING';
      break;

    case MovieListType.TopRated:
      return 'TOP RATED';
      break;

    default:
      return '';
  }
}

Widget buildRating(double voteAverage) {
  return SmoothStarRating(
      allowHalfRating: false,
      starCount: 5,
      rating: voteAverage / 2,
      size: 15.0,
      color: Colors.yellow,
      borderColor: Colors.yellow,
      spacing: 1.0);
}
