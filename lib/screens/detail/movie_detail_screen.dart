import 'package:cinemax/data/movie/movie.dart';
import 'package:cinemax/data/movie/movie_detail.dart';
import 'package:cinemax/data/movie/movies.dart';
import 'package:cinemax/screens/detail/movie_cast_list_screen.dart';
import 'package:cinemax/screens/detail/movie_detail_description.dart';
import 'package:cinemax/screens/detail/movie_trailer_list.dart';
import 'package:cinemax/screens/detail/similar_movie_list.dart';
import 'package:cinemax/services/movie/movie_services.dart';
import 'package:cinemax/util/url_constant.dart';
import 'package:flutter/material.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({Key key, this.movie}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MovieDetailScreenState();
  }
}

class MovieDetailScreenState extends State<MovieDetailScreen>
    with SingleTickerProviderStateMixin {
  MovieDetail detail;
  TabController _controller;
  List<Movie> relatedMovies;

  _getMovieDetail(int movieId) async {
    var data = await MovieServices().getMovieDetail(movieId);
    var movieDetail = MovieDetail.fromJson(data);
    setState(() {
      detail = movieDetail;
    });
  }

  _getRelatedMovies(int movieId) async {
    var data = await MovieServices().getRelatedMovies(movieId, 1);
    var list = Movies.fromJson(data);
    setState(() {
      relatedMovies = list.results;
    });
  }

  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this);
    if (widget.movie != null) {
      _getMovieDetail(widget.movie.id);
      _getRelatedMovies(widget.movie.id);
    }
    super.initState();
  }

  Widget similarMovieListComponents() {
    Widget similarComponent;
    if (relatedMovies == null) {
      similarComponent = Center(
        child: CircularProgressIndicator(),
      );
    } else if (relatedMovies != null && relatedMovies.length == 0) {
      similarComponent = Center(
        child: Text("No Related movies found"),
      );
    } else {
      similarComponent = SimilarMovieList(
        relatedMovies: relatedMovies,
      );
    }
    return similarComponent;
  }

  Widget getMoviesTrailerWidget() {
    Widget components;
    if (relatedMovies == null || detail == null) {
      components = Center(
        child: CircularProgressIndicator(),
      );
    } else if (detail != null &&
        detail.videos != null &&
        detail.videos.results.length == 0) {
      components = Center(
        child: Text("No Videos available"),
      );
    } else {
      components = MovieTrailerList(detail.videos.results);
    }
    return components;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: Container(
        child: detail == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  Stack(children: <Widget>[
                    Container(
                      height: 250,
                      child: FadeInImage.assetNetwork(
                          image:
                              '${kPosterImageBaseUrl}w500/${detail.backdropPath ?? detail.posterPath}',
                          placeholder: 'assets/images/loading.gif',
                          fit: BoxFit.cover),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                              Colors.black,
                              Colors.black38.withOpacity(0.1)
                            ])),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 50,
                      right: 10,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              detail.title,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                              // maxLines: 3,
                              // textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                  TabBar(controller: _controller, tabs: <Tab>[
                    Tab(text: "Detail",icon: Icon(Icons.description,color: Colors.white,),),
                    Tab(text: "Related",icon: Icon(Icons.more,color: Colors.white,)),
                    Tab(text: "Trailers" ,icon: Icon(Icons.video_library,color: Colors.white,)),
                    Tab(text: "Cast",icon: Icon(Icons.cast,color: Colors.white,)),
                  ]),
                  Expanded(
                    child: TabBarView(
                      controller: _controller,
                      children: <Widget>[
                        MovieDetailDiscription(
                          detail: detail,
                        ),
                        similarMovieListComponents(),
                        getMoviesTrailerWidget(),
                        MovieCastList()
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
