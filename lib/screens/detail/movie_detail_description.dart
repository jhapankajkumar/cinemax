import 'package:cinemax/data/movie/movie_detail.dart';
import 'package:flutter/material.dart';

class MovieDetailDiscription extends StatelessWidget {
  final MovieDetail detail;

  const MovieDetailDiscription({Key key, this.detail}) : super(key: key);
  @override
  Widget build(BuildContext context) { 
    return Container(
      padding:EdgeInsets.symmetric(horizontal: 8,vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getGenereView(context),
          SizedBox(height: 40,),
          getPlotView(context),
        ],
      ),
    );
  }

  Widget getGenereView(BuildContext context){
    return detail.genres != null ?
     Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Genres',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), ),
        SizedBox(height: 5,),
        Divider(height: 3, color: Colors.grey,),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: detail.genres.map((genre) {
          return Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10),color: Colors.deepOrangeAccent),
          child: Text(genre.name, style: TextStyle(color: Colors.black),),
        );
          }).toList(),
        )
      ],
    ): Container();
  }

  Widget getPlotView(BuildContext context){
    return detail.genres != null ?
     Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Synopsis',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), ),
        SizedBox(height: 5,),
        Divider(height: 3, color: Colors.grey,),
        SizedBox(height: 10,),
        Text(detail.overview,style: TextStyle(fontSize: 16,), maxLines: 10, ),
        
      ],
    ): Container();
  }

}

