import 'package:cinemax/data/movie/movie.dart';
import 'package:cinemax/util/url_constant.dart';
import 'package:flutter/material.dart';

class CardListCell {
 static Widget buildCardCell(int index, BuildContext context, List<Movie> movielist, Function cardDidTap) {
    
    int indexone = index * 3;
    int indexTwo = index * 3 + 1;
    int indexThree = index * 3 + 2;

    Movie movieone = movielist[indexone];
    Movie movieTwo;
    if (indexTwo < movielist.length){
      movieTwo = movielist[indexTwo];
    }
    Movie movieThree;
    if (indexThree < movielist.length){
      movieThree = movielist[indexThree];
    }

    return Container(
      height: 240,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 10,),
          cardWidget(movieone, indexone, context,cardDidTap),
          SizedBox(width: 10,),
          movieTwo != null ? ( cardWidget(movieTwo, indexTwo, context, cardDidTap)) : Container(),
          SizedBox(width: 10,),
          movieThree!= null ? cardWidget(movieThree, indexThree, context, cardDidTap) : Container(),
        ],
      ),
    );
  }
}

Widget cardWidget(Movie movie, int index, BuildContext context, Function cardDidTap,) {
  double cardWidht = (MediaQuery.of(context).size.width - 40) / 3;
  return GestureDetector(
    onTap: () {
      cardDidTap(movie, index, context);
    },
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      child: Stack(
        children: <Widget>[
          Container(
            width: cardWidht,
            height: 210,
            child: FadeInImage.assetNetwork(
                image: '${kPosterImageBaseUrl}w185/${movie.posterPath ?? movie.backdropPath}',
                placeholder: 'assets/images/loading.gif',
                fit: BoxFit.cover),
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
                  child: Text(
                    movie.title,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                    
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
