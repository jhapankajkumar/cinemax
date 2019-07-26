import 'package:cinemax/data/movie/movie.dart';
import 'package:cinemax/util/url_constant.dart';
import 'package:cinemax/util/utility_helper.dart';
import 'package:flutter/material.dart';

class CardListCell {
 static Widget buildCardCell(int index, BuildContext context, List<Movie> movielist, Function cardDidTap) {
    
    int indexone = index * 2;
    int indexTwo = index * 2 + 1;
    // int indexThree = index * 3 + 2;

    Movie movieone = movielist[indexone];
    Movie movieTwo;
    if (indexTwo < movielist.length){
      movieTwo = movielist[indexTwo];
    }
    // Movie movieThree;
    // if (indexThree < movielist.length){
    //   movieThree = movielist[indexThree];
    // }

    return Container(
      height: 320,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 10,),
          cardWidget(movieone, indexone, context,cardDidTap),
          SizedBox(width: 10,),
          movieTwo != null ? ( cardWidget(movieTwo, indexTwo, context, cardDidTap)) : Container(),
          // SizedBox(width: 10,),
          // movieThree!= null ? cardWidget(movieThree, indexThree, context, cardDidTap) : Container(),
        ],
      ),
    );
  }
}

Widget cardWidget(Movie movie, int index, BuildContext context, Function cardDidTap,) {
  double cardWidht = (MediaQuery.of(context).size.width - 30) / 2;
  return GestureDetector(
    onTap: () {
      cardDidTap(movie, index, context);
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: Stack(
            children: <Widget>[
              Container(
                width: cardWidht,
                height: 250,
                child: getNeworkImage('${kPosterImageBaseUrl}w500${movie.posterPath ?? movie.backdropPath}')  
              ),
              Positioned(
                left: 0,
                bottom: 0,
                height: 60,
                width: cardWidht,
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
  );
}
