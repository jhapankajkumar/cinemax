import 'package:cinemax/data/movie/movie.dart';
import 'package:cinemax/screens/detail/movie_detail_screen.dart';
import 'package:cinemax/screens/movie_list_card_cell.dart';
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
    print('Movie Lenght ${relatedMovies.length}');
    int rowCount = relatedMovies.length % 3 == 0 ? relatedMovies.length : relatedMovies.length ~/ 3 + 1;
    print("Row Count: $rowCount"); 
    return Container(
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

  
