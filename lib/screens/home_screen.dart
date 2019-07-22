import 'package:cinemax/data/genres.dart';
import 'package:cinemax/data/movie/movie.dart';
import 'package:cinemax/data/movie/movies.dart';
import 'package:cinemax/screens/base_home_screen.dart';
import 'package:cinemax/screens/detail/movie_detail_screen.dart';
import 'package:cinemax/screens/movie_list_screen.dart';
import 'package:cinemax/services/movie/movie_services.dart';
import 'package:cinemax/util/url_constant.dart';
import 'package:cinemax/util/utility_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> nowPlaying;
  List<Movie> popularList;
  List<Movie> upcomingList;
  List<Movie> topRatedList;
  List<Genre> genreList;
  List<Movie> trendingList;

  PageController pageController;
  int currentPage;
  @override
  void initState() {
    _getGenrelist();
    _getMovieListOfType(MovieListType.NowPaying);
    _getMovieListOfType(MovieListType.Upcoming);
    _getMovieListOfType(MovieListType.Popular);
    _getMovieListOfType(MovieListType.Trending);
    _getMovieListOfType(MovieListType.TopRated);
    pageController = PageController();
    pageController.addListener(() {
      // print(pageController.page);
    });
    super.initState();
  }

  _getGenrelist() async {
    var data = await MovieServices().getMovieGenreList();
    Genres list = Genres.fromJson(data);
    setState(() {
      genreList = list.genres;
    });
  }

  _getMovieListOfType(MovieListType type) async {
    switch (type) {
      case MovieListType.NowPaying:
        {
          var data = await MovieServices().getMovieList(kNowPaylingMovieUrl, 1);
          Movies list = Movies.fromJson(data);
          setState(() {
            nowPlaying = list.results;
          });
        }

        break;
      case MovieListType.Upcoming:
        {
          var data = await MovieServices().getMovieList(kUpcomingMovieUrl, 1);
          Movies list = Movies.fromJson(data);
          setState(() {
            upcomingList = list.results;
          });
        }
        break;

      case MovieListType.Trending:
        {
          var data = await MovieServices().getMovieList(kTrendingMovieUrl, 1);
          Movies list = Movies.fromJson(data);
          setState(() {
            trendingList = list.results;
          });
        }
        break;

      case MovieListType.Popular:
        {
          var data = await MovieServices().getMovieList(kPopularMovieUrl, 1);
          Movies list = Movies.fromJson(data);
          setState(() {
            popularList = list.results;
          });
        }
        break;

      case MovieListType.TopRated:
        {
          var data = await MovieServices().getMovieList(kTopRatedMovieUrl, 1);
          Movies list = Movies.fromJson(data);
          setState(() {
            topRatedList = list.results;
          });
        }
        break;

      default:
        return '';
    }
  }

  bool shouldShowLoading() {
    if (nowPlaying == null &&
        upcomingList == null &&
        popularList == null &&
        topRatedList == null &&
        trendingList == null) {
      return true;
    } else {
      return false;
    }
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
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
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
              child: Icon(Icons.search),
            )
          ],
        ),
        body: shouldShowLoading()
            ? loadingIndicator()
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      trendingList != null
                          ? Container(
                              height: 300,
                              child: PageView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                pageSnapping: true,
                                controller: pageController,
                                onPageChanged: (currentPage) {},
                                itemCount: trendingList.length,
                                itemBuilder: (context, index) {
                                  return _buildPageViewContent(
                                      context, trendingList[index]);
                                },
                              ),
                            )
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
              ));
  }
}



Widget _buildPageViewContent(BuildContext context, Movie movie) {
  return Stack(children: <Widget>[
    GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return MovieDetailScreen(movie: movie);
        }));
      },
      child: Container(
        height: 300,
        child: getNeworkImage(
            '${kPosterImageBaseUrl}w500/${movie.backdropPath ?? movie.posterPath}'),
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
                colors: [Colors.black, Colors.black38.withOpacity(0.1)])),
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
              movie.title,
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
              getTextForEnum(type),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return MovieListScreen(
                    type: type,
                  );
                }));
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
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return MovieDetailScreen(movie: movie);
      }));
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
              movie.title,
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
