import 'package:cinemax/data/movie/credits.dart';
import 'package:cinemax/services/movie/movie_services.dart';
import 'package:cinemax/util/constant.dart';
import 'package:cinemax/util/url_constant.dart';
import 'package:cinemax/util/utility_helper.dart';
import 'package:flutter/material.dart';

class CastCrewList extends StatefulWidget {
  final int movieId;

  const CastCrewList({Key key, this.movieId}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CastCrewListState();
  }
}

class CastCrewListState extends State<CastCrewList> {
  Credits credits;

  _getCredits(movieId) async {
    var data = await MovieServices().getCredits(movieId);
    var list = Credits.fromJson(data);
    setState(() {
      credits = list;
    });
  }

  @override
  void initState() {
    if (widget.movieId != null) {
      _getCredits(widget.movieId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cast & Crew'),
      ),
      body: credits != null ? Container(
          child: ListView.builder(
        itemCount: credits.cast.length + credits.crew.length,
        itemBuilder: (context, index) {
          if (index < credits.cast.length) {
            return buildCastCard(context, credits.cast[index]);
          } else {
            return buildCrewCard(
                context, credits.crew[index - credits.cast.length]);
          }
        },
      )): loadingIndicator(),
    );
  }
}

Widget buildCastCard(BuildContext context, Cast cast) {
  String character = cast.character;
  character = character.split('\/').first;
  String imageUrl = '${kPosterImageBaseUrl}w500/${cast.profilePath}';
  String name = cast.name;
  return getCard(imageUrl, name, character);
}

Widget buildCrewCard(BuildContext context, Crew crew) {
  String character = crew.job;
  character = character.split('\/').first;
  String imageUrl = '${kPosterImageBaseUrl}w500/${crew.profilePath}';
  String name = crew.name;
  return getCard(imageUrl, name, character);
}

Widget getCard(String imageUrl, String name, String character) {
  return Container(
    height: 150,
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.black26,
      shape: BoxShape.rectangle,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 50,
            backgroundColor: appTheme.primaryColor,
            backgroundImage: NetworkImage(
              imageUrl,
            )),
        SizedBox(width: 16,),   
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              
              width: 200,
              child: Text(
                '$name',
                overflow: TextOverflow.ellipsis,
                textAlign:TextAlign.left,
                style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              
              width: 200,
              child: Text(
                'Role: $character',
                overflow: TextOverflow.ellipsis,
                textAlign:TextAlign.left,
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.normal,
                    ),maxLines: 2,
              ),
            ),
            
          ],
        )
      ],
    ),
  );
}
