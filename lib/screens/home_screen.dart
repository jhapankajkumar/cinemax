import 'package:cinemax/data/genres.dart';
import 'package:cinemax/data/movie/movie.dart';
import 'package:cinemax/data/movie/movies.dart';
import 'package:cinemax/screens/detail/movie_detail_screen.dart';
import 'package:cinemax/screens/menu.dart';
import 'package:cinemax/screens/movie_list_screen.dart';
import 'package:cinemax/services/movie/movie_services.dart';
import 'package:cinemax/util/url_constant.dart';
import 'package:cinemax/util/utility_helper.dart';
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
    return Scaffold(
        drawer: Menu(genres: genreList,),
        appBar:
         AppBar( 
          title: Text(widget.title),
          actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(Icons.search),
              )
            ],
        ),
        body: shouldShowLoading()
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      trendingList != null ? Container(
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
                      ): Container(),
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

Widget appBar () {
  return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      expandedHeight: 250.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Demo'),
      ),
    );
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
        child: FadeInImage.assetNetwork(
            image:
                '${kPosterImageBaseUrl}w500/${movie.backdropPath ?? movie.posterPath}',
            placeholder: 'assets/images/loading.gif',
            fit: BoxFit.cover),
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
        height: 240,
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
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: Stack(
              children: <Widget>[
                Container(
                  width: 160,
                  height: 210,
                  child: FadeInImage.assetNetwork(
                      image: '${kPosterImageBaseUrl}w185/${movie.posterPath}',
                      placeholder: 'assets/images/loading.gif',
                      fit: BoxFit.cover),
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
                        child: Text(
                          movie.title,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                          // maxLines: 3,
                          // textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
