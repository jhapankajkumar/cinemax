import 'package:cinemax/common_widgets/movie_list_card_cell.dart';
import 'package:cinemax/data/movie/movie.dart';
import 'package:cinemax/screens/movie_detail/movie_detail_screen.dart';
import 'package:cinemax/util/constant.dart';
import 'package:flutter/material.dart';

class SimilarMovieList extends StatelessWidget {
  final List<Movie> relatedMovies;

  const SimilarMovieList({Key key, this.relatedMovies}) : super(key: key);
   
   void _cardDidTap(Movie movie, int index, BuildContext context){
     Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return MovieDetailScreen(
          movie: movie,
        );
      }));
   }
  
  @override
  Widget build(BuildContext context) {
    if (relatedMovies == null) {
      return Center( child:Text('No Related movies found', style: titleStyle,));
    }
    else if (relatedMovies.length == 0) {
      return Center( child:Text('No Related movies found', style: titleStyle,));
    }
    int rowCount = relatedMovies.length % 3 == 0 ? relatedMovies.length : relatedMovies.length ~/ 3 + 1;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: rowCount,
        itemBuilder: (context, index) {
          return CardListCell.buildCardCell(index, context, relatedMovies, _cardDidTap);
        },
      ),
    );
  }
}

  
