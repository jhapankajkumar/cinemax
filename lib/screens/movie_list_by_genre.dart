import 'package:cinemax/data/genres.dart';
import 'package:cinemax/data/movie/movie.dart';
import 'package:cinemax/data/movie/movies.dart';
import 'package:cinemax/screens/detail/movie_detail_screen.dart';
import 'package:cinemax/screens/movie_list_card_cell.dart';
import 'package:cinemax/services/movie/movie_services.dart';
import 'package:cinemax/util/utility_helper.dart';
import 'package:flutter/material.dart';

class GenreMovieListScreen extends StatefulWidget {
  final Genre genre;

  const GenreMovieListScreen({Key key, this.genre}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() {
    return GenreMovieListScreenState();
  }
}

class GenreMovieListScreenState extends State<GenreMovieListScreen> {
  List<Movie> movieList;
  int currentPage;
  int totalPage;
  @override
  void initState() {
    currentPage = 1;
    if (widget.genre != null){
      _getMovieList(widget.genre.id , currentPage);
    }
    super.initState();
  }

  _getMovieList(int genreId,int pageNo) async {
      var data = await MovieServices().getMovieListByGenre(genreId, pageNo);
      Movies list = Movies.fromJson(data);
      setState(() {
        currentPage = currentPage + 1;
        if (movieList != null) {
          List<Movie> newList = List.from(movieList)..addAll(list.results);
          movieList = newList;
        } else {
          totalPage = list.totalPages;
          movieList = list.results;
        }
      });
    }

  @override
  Widget build(BuildContext context) {
    String title = '';
    if (widget.genre != null) {
      title = widget.genre.name;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _getBuidComponent(),
    );
  }
  


  void _cardDidTap(Movie movie, int index, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return MovieDetailScreen(
        movie: movie,
      );
    }));
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
      print('Movie Lenght ${movieList.length}');
      int rowCount = 0;
      if (movieList.length % 3 == 0){
          rowCount = movieList.length ~/ 3;
      }
      else {
        rowCount = movieList.length ~/ 3 + 1;
      }
      print("Row Count: $rowCount");
      component = Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: rowCount,
          itemBuilder: (context, index) {
            if (index  == rowCount - 1 &&  currentPage <= totalPage) {  
              _getMovieList(widget.genre.id,currentPage);
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