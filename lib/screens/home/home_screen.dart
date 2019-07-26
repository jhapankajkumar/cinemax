import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemax/common_widgets/custom_transition.dart';
import 'package:cinemax/data/genres.dart';
import 'package:cinemax/data/movie/movie.dart';
import 'package:cinemax/data/movie/movies.dart';
import 'package:cinemax/screens/home/base_home_screen.dart';
import 'package:cinemax/screens/movie_detail/movie_detail_screen.dart';
import 'package:cinemax/screens/movie_list/movie_list_screen.dart';
import 'package:cinemax/screens/movie_list/search.dart';
import 'package:cinemax/services/movie/movie_services.dart';
import 'package:cinemax/util/constant.dart';
import 'package:cinemax/util/url_constant.dart';
import 'package:cinemax/util/utility_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int requestCount = 0;
  List<Movie> nowPlaying;
  List<Movie> popularList;
  List<Movie> upcomingList;
  List<Movie> topRatedList;
  List<Genre> genreList;
  List<Movie> trendingList;
  RefreshController _refreshController;

  int currentPage;
  @override
  void initState() {
    requestCount = 0;
    _refreshController = RefreshController();
    _refresh();
    super.initState();
  }

  _getMovieListOfType(MovieListType type) async {
    requestCount += 1;
    switch (type) {
      case MovieListType.NowPaying:
        {
          await MovieServices()
              .fetchMovieList(kNowPaylingMovieUrl, 1)
              .then((movies) {
            requestCount -= 1;

            setState(() {
              nowPlaying = movies.results;
            });
          }).catchError((onError) {
            setState(() {
              requestCount -= 1;
            });
          });
        }

        break;
      case MovieListType.Upcoming:
        {
          await MovieServices()
              .fetchMovieList(kUpcomingMovieUrl, 1)
              .then((movies) {
            requestCount -= 1;

            setState(() {
              upcomingList = movies.results;
            });
          }).catchError((onError) {
            setState(() {
              requestCount -= 1;
            });
          });
        }
        break;

      case MovieListType.Trending:
        {
          await MovieServices()
              .fetchMovieList(kTrendingMovieUrl, 1)
              .then((movies) {
            requestCount -= 1;
            setState(() {
              trendingList = movies.results;
            });
          }).catchError((onError) {
            setState(() {
              requestCount -= 1;
            });
          });
        }
        break;

      case MovieListType.Popular:
        {
          await MovieServices()
              .fetchMovieList(kPopularMovieUrl, 1)
              .then((movies) {
            requestCount -= 1;
            setState(() {
              popularList = movies.results;
            });
          }).catchError((onError) {
            setState(() {
              requestCount -= 1;
            });
          });
        }
        break;

      case MovieListType.TopRated:
        {
          await MovieServices()
              .fetchMovieList(kTopRatedMovieUrl, 1)
              .then((movies) {
            requestCount -= 1;

            setState(() {
              topRatedList = movies.results;
            });
          }).catchError((onError) {
            setState(() {
              requestCount -= 1;
            });
          });
        }
        break;
    }
    
  }

  bool shouldShowLoading() {
    if (requestCount == 0) {
      return false;
    }

    print('SHOULD LOADING CALLED');
    if (nowPlaying != null ||
        upcomingList != null ||
        popularList != null ||
        topRatedList != null ||
        trendingList != null) {
      return false;
    } else {
      return true;
    }
  }

  _refresh() {
    requestCount = 0;
    _getMovieListOfType(MovieListType.NowPaying);
    _getMovieListOfType(MovieListType.Upcoming);
    _getMovieListOfType(MovieListType.Popular);
    _getMovieListOfType(MovieListType.Trending);
    _getMovieListOfType(MovieListType.TopRated);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return BaseHomeScreen(
        appBar: AppBar(
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.title,
                  style: titleStyle,
                ),
                // IconButton(
                //     icon: Container(
                //       height: 30.0,
                //       width: 30.0,
                //       decoration: BoxDecoration(
                //         color: appTheme.accentColor,
                //         shape: BoxShape.circle,
                //       ),
                //       child: Center(
                //         child: Icon(
                //           // expandFlag
                //           //     ? Icons.keyboard_arrow_up
                //           Icons.keyboard_arrow_down,
                //           color: Colors.white,
                //           size: 20.0,
                //         ),
                //       ),
                //     ),
                //     onPressed: () {
                //       Navigator.push(context,
                //           MaterialPageRoute(builder: (BuildContext context) {
                //         return MoreMore(
                //             child: ListView.builder(
                //           itemBuilder: (BuildContext context, int index) {
                //             return Container(
                //               decoration: BoxDecoration(
                //                   border: Border(
                //                     top: BorderSide(
                //                       color: appTheme.accentColor,
                //                       width: 1.0,
                //                     ),
                //                     bottom: BorderSide(
                //                       color: appTheme.accentColor,
                //                       width: 1.0,
                //                     ),
                //                   ),
                //                   color: Colors.transparent),
                //               child: ListTile(
                //                 onTap: () {
                //                   // setState(() {
                //                   //   selectedIndex = index;
                //                   // });
                //                 },
                //                 title: Text(
                //                   genreList[index].name,
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.white),
                //                 ),
                //               ),
                //             );
                //           },
                //           itemCount: genreList.length,
                //         ));
                //       }));
                //     }),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return SearchMovie();
                    }));
                  },
                ))
          ],
        ),
        body: shouldShowLoading()
            ? loadingIndicator()
            : SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                header: WaterDropMaterialHeader(
                  backgroundColor: appTheme.primaryColor,
                ),
                onRefresh: () {
                  _refresh();
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        trendingList != null
                            ? _buildCarouselView()
                            : Container(),
                        SizedBox(
                          height: 20,
                        ),
                        nowPlaying != null
                            ? _buildMovieList(
                                context, nowPlaying, MovieListType.NowPaying)
                            : Container(),
                        upcomingList != null
                            ? _buildMovieList(
                                context, upcomingList, MovieListType.Upcoming)
                            : Container(),
                        popularList != null
                            ? _buildMovieList(
                                context, popularList, MovieListType.Popular)
                            : Container(),
                        trendingList != null
                            ? _buildMovieList(
                                context, trendingList, MovieListType.Trending)
                            : Container(),
                        topRatedList != null
                            ? _buildMovieList(
                                context, topRatedList, MovieListType.TopRated)
                            : Container(),
                      ],
                    ),
                  ),
                )));
  }

  Widget _buildCarouselView() {
    return Container(
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
          items: pageViewList(trendingList, context),
          //pageViewList(trendingList, context)
        ),
      ),
    );
  }
}

List<Widget> pageViewList(List<Movie> trendingList, BuildContext context) {
  var list = trendingList.map((movie) {
    return _buildPageViewContent(context, movie);
  }).toList();
  return list;
}

Widget _buildPageViewContent(BuildContext context, Movie movie) {
  return Stack(children: <Widget>[
    GestureDetector(
      onTap: () {
        Navigator.push(
            context, ScaleRoute(page: MovieDetailScreen(movie: movie)));
      },
      child: Container(
        // height: 300,
        child: getNeworkImage(
            '${kPosterImageBaseUrl}w500${movie.backdropPath ?? movie.posterPath}'),
      ),
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
                colors: [Colors.black, Colors.black38.withOpacity(0.0)])),
      ),
    ),
    Positioned(
      left: 10,
      bottom: 10,
      right: 10,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              movie.originalTitle,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20.0,
                color: Colors.white,
              ),
              // maxLines: 3,
              // textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: 60,
            width: 60,
            decoration:
                BoxDecoration(color: Colors.black, shape: BoxShape.circle),
            child: buildChart(movie.voteAverage, Size(60, 60)),
          )
        ],
      ),
    )
  ]);
}

Widget _buildMovieList(
    BuildContext context, List<Movie> movies, MovieListType type) {
  return Container(
      child: Column(
    children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              type.toString(),
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10,
            ),
            FlatButton(
              child: Text("View More",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.push(
                    context,
                    SizeRoute(
                        page: MovieListScreen(
                      type: type,
                    )));
              },
            )
          ],
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        height: 280,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return buildCard(movies[index], context);
          },
        ),
      ),
    ],
  ));
}

Widget buildCard(Movie movie, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context, ScaleRoute(page: MovieDetailScreen(movie: movie)));
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (BuildContext context) {
      //   return MovieDetailScreen(movie: movie);
      // }));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: Stack(
              children: <Widget>[
                // Container(
                //   height: 210,
                //   width: 160,
                //   child: AspectRatio(
                //     aspectRatio: 160 / 210,
                //     child: getNeworkImage(
                //         '${kPosterImageBaseUrl}w185${movie.posterPath}'),
                //   ),
                // ),
                Container(
                  width: 160,
                  height: 210,
                  child: getNeworkImage(
                      '${kPosterImageBaseUrl}w185/${movie.posterPath}'),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  height: 60,
                  width: 160,
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
                  bottom: 10,
                  right: 10,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: buildRating(movie.voteAverage),
                      ),
                      Text(
                        '${movie.voteAverage}/10',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 160,
            child: Text(
              movie.originalTitle,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.left,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(movie.releaseDate.year.toString(),
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey))
        ],
      ),
    ),
  );
}
