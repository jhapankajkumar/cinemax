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
import 'package:cinemax/screens/movie_detail/similar_movie_list.dart';
import 'package:cinemax/services/movie/movie_services.dart';
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
    var data = await MovieServices().getMovieReviews(movieId,page);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
                icon: Icon(Icons.cast),
                iconSize: 30,
                onPressed: (){
                  if (widget.movie.id != null) {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                    return CastCrewList(movieId: widget.movie.id,);
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
                  // SliverPadding(
                  //   padding: EdgeInsets.only(top: 60),

                  // ),
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    //title: Text(widget.movie.title),

                    pinned: false,
                    expandedHeight: 200.0,

                    flexibleSpace: Container(
                        height: 200,
                        child: PageView.builder(
                          // physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          pageSnapping: true,
                          controller: pageController,
                          onPageChanged: (currentPage) {},
                          itemCount: detail.images.backdrops.length,
                          itemBuilder: (context, index) {
                            return _buildPageViewContent(
                                context, detail.images.backdrops[index]);
                          },
                        ),
                      ),
                  ),
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
              MovieRevies(reviews: reviews,),
              similarMovieListComponents(),
              MovieTrailerList(videoList),
              
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPageViewContent(BuildContext context, Poster image) {
    String url = '${kPosterImageBaseUrl}w780/${image.filePath}';
    print(url);
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: getNeworkImage(url),
    );
  }
}
