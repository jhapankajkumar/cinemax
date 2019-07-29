import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemax/common_widgets/custom_transition.dart';
import 'package:cinemax/data/image/images.dart';
import 'package:cinemax/data/movie/credits.dart';
import 'package:cinemax/data/movie/movie.dart';
import 'package:cinemax/data/movie/movie_detail.dart';

import 'package:cinemax/data/movie/reviews.dart';
import 'package:cinemax/data/video/video.dart';

import 'package:cinemax/screens/cast_and_crew/cast_and_crew_screen.dart';
import 'package:cinemax/screens/movie_detail/movie_detail_description.dart';
import 'package:cinemax/screens/movie_detail/movie_revies.dart';
import 'package:cinemax/screens/movie_detail/movie_trailer_list.dart';
import 'package:cinemax/screens/movie_detail/poster_gallary.dart';
import 'package:cinemax/screens/movie_detail/similar_movie_list.dart';
import 'package:cinemax/services/movie/movie_services.dart';
import 'package:cinemax/util/constant.dart';
import 'package:cinemax/util/url_constant.dart';
import 'package:cinemax/util/utility_helper.dart';
import 'package:flutter/cupertino.dart';
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
  List<Video> videoList;
  TabController _controller;
  List<Movie> relatedMovies;
  List<Review> reviews;
  Credits credits;
  PageController pageController;
  int currentPage;
  APIStatus status = APIStatus.InProcess;

  _getMovieDetail(int movieId) async {
    await MovieServices().fetchMovieDetailWithId(movieId).then((movieDetail) {
      setState(() {
        status = APIStatus.Success;
        detail = movieDetail;
      });
    }).catchError((onError) {
      setState(() {
        status = APIStatus.Failed;  
      });
      
    });
  }

  _getRelatedMovies(int movieId) async {
    await MovieServices().fetchRelatedMovies(movieId, 1).then((movies) {
      setState(() {
        relatedMovies = movies.results;
      });
    }).catchError((onError) {});
  }

  

  _getMovieReview(int movieId, page) async {
    await MovieServices().fetchMovieReviews(movieId, page).then((movieReviews) {
      print(movieReviews.results.length);
      setState(() {
        reviews = movieReviews.results;
      });
    }).catchError((onError) {});
  }

  _getCredits(movieId) async {
    await MovieServices().fetchCredits(movieId).then((Credits movieCredits) {
      setState(() {
          credits = movieCredits;
      });
    }).catchError((onError) {
      print(onError);
      setState(() {
         
      });
    });
  }

  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this);
    pageController = PageController();
    if (widget.movie != null) {
      _getMovieDetail(widget.movie.id);
      _getMovieReview(widget.movie.id, 1);
      _getRelatedMovies(widget.movie.id);
      _getCredits(widget.movie.id);
      
    }
    super.initState();
  }

  Widget similarMovieListComponents() {
    Widget similarComponent;
    if (relatedMovies == null) {
      similarComponent = loadingIndicator();
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

  

  _showGallery() {
    Navigator.push(
        context,
        SizeRoute(
            page: PosterGallery(
          posters: List.from(detail.images.posters)
            ..addAll(detail.images.backdrops),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movie.title,
          style: titleStyle,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(Icons.videocam),
              iconSize: 30,
              onPressed: () {
                if (widget.movie.id != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return YoutubeDefaultWidget(
                      widget.movie.id,
                    );
                  }));
                }
              },
            ),
          ),
        ],
      ),
      body: Container(
        child: status == APIStatus.InProcess
            ? loadingIndicator()
            : (status == APIStatus.Failed
                ? Center(
                    child: Text('Detail not found', style: titleStyle),
                  )
                : CustomScrollView(
                    slivers: <Widget>[
                      SliverList(delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          /// To convert this infinite list to a list with "n" no of items,
                          /// uncomment the following line:
                          if (index > 0) return null;
                          return GestureDetector(
                            onTap: () {
                              _showGallery();
                            },
                            child: Container(
                              child: Stack(
                                children: <Widget>[
                                  buildPageViewContainer(),
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
                                            Colors.black38.withOpacity(0.0)
                                          ])),
                                    ),
                                  ),
                                  Positioned(
                                    left: 15,
                                    bottom: 5,
                                    right: 15,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: 270,
                                              child: Text(
                                                detail.originalTitle,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 20.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  getDateStrinFromDate(
                                                      detail.releaseDate),
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  '${detail.runtime.toString()} min',
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle),
                                          child: buildChart(
                                              detail.voteAverage, Size(60, 60)),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )),
                      SliverList(delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          /// To convert this infinite list to a list with "n" no of items,
                          /// uncomment the following line:
                          if (index > 0) return null;
                          return Container(
                            height: MediaQuery.of(context).size.height - 300,
                            child: tabBar(),
                          );
                        },
                      ))
                    ],
                  )),
      ),
    );
  }

  Widget tabBar() {
    return Column(
      children: <Widget>[
        TabBar(controller: _controller, tabs: <Tab>[
          Tab(
            text: "Detail",
            icon: Icon(
              Icons.description,
              color: Colors.white,
            ),
          ),
          Tab(
              text: "Reviews",
              icon: Icon(
                Icons.rate_review,
                color: Colors.white,
              )),
          Tab(
              text: "Related",
              icon: Icon(
                Icons.more,
                color: Colors.white,
              )),
          Tab(
              text: "Casts",
              icon: Icon(
                Icons.cast,
                color: Colors.white,
              )),
        ]),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: <Widget>[
              MovieDetailDiscription(
                detail: detail,
              ),
              MovieRevies(
                reviews: reviews,
              ),
              SimilarMovieList(
                relatedMovies: relatedMovies,
              ),
              CastCrewList(credits),
            ],
          ),
        ),
      ],
    );
  }

  //Page View Container
  Widget buildPageViewContainer() {
    List<Poster> posters;
    if(detail.images.backdrops.length > 0){
      posters = detail.images.backdrops;
    }
    else if (detail.images.posters.length > 0) {
      posters = detail.images.posters;
    }
    else {
      return Container(
        height: 250,
      );
    }
    return GestureDetector(
      child: Container(
        height: 250,
        padding: EdgeInsets.all(10),
        // decoration: BoxDecoration(border: Border.all(width: 1.0), borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: CarouselSlider(
            scrollDirection: Axis.horizontal,
            height: 250,
            viewportFraction: 1.0,
            initialPage: 0,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            pauseAutoPlayOnTouch: Duration(seconds: 2),
            enlargeCenterPage: true,
            autoPlay: posters.length == 1 ? false : true,
            onPageChanged: (index) {
              // setState(() {
              //   _currentIndex = index;
              //   print(_currentIndex);
              // });
            },
            items: pageViewList(posters, context),
            //pageViewList(trendingList, context)
          ),
        ),
      ),
    );
  }
}

List<Widget> pageViewList(List<Poster> posters, BuildContext context) {
  if (posters.length > 0){
     var list = posters.map((poster) {
    return buildPageViewContent(context, poster.filePath);
  }).toList();
  return list;
  }
  else {
    return [];
  }
}

Widget buildPageViewContent(BuildContext context, String filePath) {
  return Container(
    child: getNeworkImage('${kPosterImageBaseUrl}w780$filePath'),
  );
}
