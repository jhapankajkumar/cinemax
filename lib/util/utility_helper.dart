import 'dart:io' show Platform;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemax/data/movie/movie.dart';
import 'package:cinemax/data/movie/movies.dart';
import 'package:cinemax/util/url_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

Widget loadingIndicator() {
  Widget indicator;
  if (Platform.isAndroid) {
    indicator = Center(
      child: CircularProgressIndicator(),
    );
  } else if (Platform.isIOS) {
    indicator = Center(
      child: CupertinoActivityIndicator(
        radius: 20,
      ),
    );
  }
  return indicator;
}

class MovieListType {
  final _value;
  final _url;
  const MovieListType._internal(this._value, this._url);
  toString() => '$_value';
  url() => _url;

  static const NowPaying =
      const MovieListType._internal('NOW PLAYING', kNowPaylingMovieUrl);
  static const Upcoming =
      const MovieListType._internal('UPCOMING', kUpcomingMovieUrl);
  static const Popular =
      const MovieListType._internal('POPULAR', kPopularMovieUrl);
  static const Trending =
      const MovieListType._internal('TRENDING', kTrendingMovieUrl);
  static const TopRated =
      const MovieListType._internal('TOP RATED', kTopRatedMovieUrl);
}

class SortType {
  final _value;
  const SortType._internal(this._value);
  toString() => '$_value';

  static const TitleAsc = const SortType._internal('Title (A-Z)');
  static const TitleDesc = const SortType._internal('Title (Z-A)');
  static const RatingAsc = const SortType._internal('Rating (Low - High)');
  static const RatingDesc = const SortType._internal('Rating (High - Low)');
  static const ReleaseDateAsc =
      const SortType._internal('Relase Date (Latest)');
  static const ReleaseDateDesc =
      const SortType._internal('Release Date (Oldest)');
}

List<SortType> getSortList() {
  return [
    SortType.TitleAsc,
    SortType.TitleDesc,
    SortType.RatingAsc,
    SortType.RatingDesc,
    SortType.ReleaseDateAsc,
    SortType.ReleaseDateDesc
  ];
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

List<Movie> getSortedListWithType(List<Movie> list, SortType type) {
  List<Movie> sortedList = List.from(list);
  switch (type) {
    case SortType.TitleAsc:
      {
        sortedList.sort((a, b) {
          return a.title.toLowerCase().compareTo(b.title.toLowerCase());
        });
      }
      break;
    case SortType.TitleDesc:
      {
        sortedList.sort((a, b) {
          return b.title.toLowerCase().compareTo(a.title.toLowerCase());
        });
      }
      break;
    case SortType.RatingAsc:
      {
        sortedList.sort((a, b) {
          return a.voteAverage.toString().compareTo(b.voteAverage.toString());
        });
      }
      break;
    case SortType.RatingDesc:
      {
        sortedList.sort((a, b) {
          return b.voteAverage.toString().compareTo(a.voteAverage.toString());
        });
      }
      break;
    case SortType.ReleaseDateAsc:
      {}
      break;
    case SortType.ReleaseDateDesc:
      {}
      break;
  }

  return sortedList;
}

Widget getNeworkImage(String imagePath) {
  return CachedNetworkImage(
    imageUrl: imagePath,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    ),
    placeholder: (context, url) => loadingIndicator(),
    errorWidget: (context, url, error) => Image.asset(
      'assets/images/placeholder.jpg',
      fit: BoxFit.cover,
    ),
  );
}
