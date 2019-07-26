import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemax/common_widgets/custom_transition.dart';
import 'package:cinemax/data/image/images.dart';
import 'package:cinemax/data/movie/movie.dart';
import 'package:cinemax/data/movie/movie_detail.dart';
import 'package:cinemax/data/movie/movies.dart';
import 'package:cinemax/data/movie/reviews.dart';
import 'package:cinemax/data/video/video.dart';
import 'package:cinemax/data/video/videos.dart';
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
  PageController pageController;
  int currentPage;

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

  _getVideoList(int movieId) async {
    var data = await MovieServices().getVideoList(movieId);
    var list = Videos.fromJson(data);
    setState(() {
      videoList = list.results;
    });
  }

  _getMovieReview(int movieId, page) async {
    var data = await MovieServices().getMovieReviews(movieId, page);
    var list = Reviews.fromJson(data);
    setState(() {
      reviews = list.results;
    });
  }

  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this);
    pageController = PageController();
    if (widget.movie != null) {
      _getMovieDetail(widget.movie.id);
      _getRelatedMovies(widget.movie.id);
      _getVideoList(widget.movie.id);
      _getMovieReview(widget.movie.id, 1);
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

  Widget getMoviesTrailerWidget() {
    Widget components;
    if (relatedMovies == null || detail == null) {
      components = loadingIndicator();
    } else if (videoList != null && videoList.length == 0) {
      components = Center(
        child: Text("No Videos available"),
      );
    } else {
      components = MovieTrailerList(videoList);
    }
    return components;
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
              icon: Icon(Icons.cast),
              iconSize: 30,
              onPressed: () {
                if (widget.movie.id != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CastCrewList(
                      movieId: widget.movie.id,
                    );
                  }));
                }

                print('Cast And Crew');
              },
            ),
          ),
        ],
      ),
      body: Container(
        child: detail == null
            ? loadingIndicator()
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
                                bottom:5,
                                right: 15,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                       Container(
                                         width: 270,
                                         child: Text(
                                          detail.originalTitle,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign:TextAlign.left,
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20.0,
                                            color: Colors.white,
                                            
                                          ),
                                      ),
                                       ),
                                      SizedBox(height: 10,),
                                      Row(children: <Widget>[
                                        
                                        Text(getDateStrinFromDate(detail.releaseDate),
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
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
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      ],)
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
                        height: MediaQuery.of(context).size.height - 250,
                        child: tabBar(),
                      );
                    },
                  ))
                ],
              ),
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
              text: "Videos",
              icon: Icon(
                Icons.video_library,
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
              similarMovieListComponents(),
              MovieTrailerList(videoList),
            ],
          ),
        ),
      ],
    );
  }

  //Page View Container
  Widget buildPageViewContainer() {
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
            autoPlay: true,
            onPageChanged: (index) {
              // setState(() {
              //   _currentIndex = index;
              //   print(_currentIndex);
              // });
            },
            items: pageViewList(detail.images.backdrops, context),
            //pageViewList(trendingList, context)
          ),
        ),
      ),
    );
  }
}

List<Widget> pageViewList(List<Poster> posters, BuildContext context) {
  var list = posters.map((poster) {
    return buildPageViewContent(context, poster.filePath);
  }).toList();
  return list;
}

Widget buildPageViewContent(BuildContext context, String filePath) {
  return Container(
    child: getNeworkImage('${kPosterImageBaseUrl}w780$filePath'),
  );
}


