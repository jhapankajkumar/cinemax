import 'package:cinemax/data/movie/movie_detail.dart';
import 'package:cinemax/screens/movie_list/movie_list_by_genre.dart';
import 'package:cinemax/util/constant.dart';
import 'package:flutter/material.dart';

class MovieDetailDiscription extends StatelessWidget {
  final MovieDetail detail;

  const MovieDetailDiscription({Key key, this.detail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            getGenereView(context),
            SizedBox(
              height: 20,
            ),
            getPlotView(context),
            SizedBox(
              height: 20,
            ),
            getRatingView(context, detail.voteAverage),
            
          ],
        ),
      ),
    );
  }

  Widget getGenereView(BuildContext context) {
    return detail.genres != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Genres',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                height: 3,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                direction: Axis.horizontal,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: detail.genres.map((genre) {
                  return GestureDetector(
                    onTap: () {
                      print(genre.name);
                      print(genre.id);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return GenreMovieListScreen(
                            genre: genre, isFromDetail: true);
                      }));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          color: appTheme.accentColor),
                      child: Text(
                        genre.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          )
        : Container();
  }

  Widget getRatingView(BuildContext context, double voteAverage) {
    return detail.genres != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Rating :',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${detail.voteAverage}/10 ( ${detail.voteCount} votes )',
                    style: TextStyle(fontSize: 16,),
                  ),
                  
                ],
              ),
              SizedBox(
                    height: 20,
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Budget :',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '\$${detail.budget}',
                    style: TextStyle(fontSize: 16,),
                  ),
                  
                ],
              ),

              SizedBox(
                    height: 20,
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Revenu :',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '\$${detail.revenue}',
                    style: TextStyle(fontSize: 16,),
                  ),
                  
                ],
              ),

            ],
          )
        : Container();
  }

  Widget getPlotView(BuildContext context) {
    return detail.genres != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Synopsis',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                height: 3,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                detail.overview,
                style: TextStyle(
                  fontSize: 16,
                ),
                // maxLines: 10,
              ),
            ],
          )
        : Container();
  }
}
