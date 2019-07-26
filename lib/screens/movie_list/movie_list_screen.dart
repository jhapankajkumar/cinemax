import 'package:cinemax/common_widgets/custom_transition.dart';
import 'package:cinemax/common_widgets/movie_list_card_cell.dart';
import 'package:cinemax/data/movie/movie.dart';
import 'package:cinemax/screens/movie_detail/movie_detail_screen.dart';
import 'package:cinemax/services/movie/movie_services.dart';
import 'package:cinemax/util/constant.dart';
import 'package:cinemax/util/utility_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieListScreen extends StatefulWidget {
  final MovieListType type;

  const MovieListScreen({Key key, this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MovieListScreenState();
  }
}

class MovieListScreenState extends State<MovieListScreen> {
  List<Movie> movieList;
  int currentPage;
  int totalPage;
  SortType sortType;
  @override
  void initState() {
    currentPage = 1;
    sortType = SortType.RatingDesc;
    _getMovieList(currentPage);
    super.initState();
  }

  _getMovieList(int pageNo) async {
    if (widget.type != null) {
      String movieUrl = widget.type.url();
      await MovieServices().fetchMovieList(movieUrl, pageNo).then((movies) {
        setState(() {
          currentPage = currentPage + 1;
          if (movieList != null) {
            List<Movie> newList = List.from(movieList)..addAll(movies.results);
            movieList = newList; 
          } else {
            totalPage = movies.totalPages;
            movieList =
                movies.results; 
          }
        });
      }).catchError((onError) {
        
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    String title = '';
    if (widget.type != null) {
      title = widget.type.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: titleStyle,
        ),
        actions: <Widget>[
        ],
      ),
      body: _getBuidComponent(),
    );
  }

  void _cardDidTap(Movie movie, int index, BuildContext context) {
    Navigator.push(context, ScaleRoute(page: MovieDetailScreen(movie: movie)));
  }

  Widget _getBuidComponent() {
    Widget component = Container();

    if (movieList == null) {
      component = loadingIndicator();
    } else if (movieList.length == 0) {
      component = Center(
        child: Text('No Data Available'),
      );
    } else {
      int rowCount = 0;
      if (movieList.length % 2 == 0) {
        rowCount = movieList.length ~/ 2;
      } else {
        rowCount = movieList.length ~/ 2 + 1;
      }
      component = Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: rowCount,
          itemBuilder: (context, index) {
            if (index == rowCount - 1 && currentPage < totalPage) {
              _getMovieList(currentPage);
              return loadingIndicator();
            } else {
              return CardListCell.buildCardCell(
                  index, context, movieList, _cardDidTap);
            }
          },
        ),
      );
    }
    return component;
  }
}
