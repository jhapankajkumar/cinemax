
import 'package:cinemax/data/movie/reviews.dart';
import 'package:flutter/material.dart';

class MovieRevies extends StatelessWidget {

  final List<Review> reviews;

  const MovieRevies({Key key, this.reviews}) : super(key: key);@override
  Widget build(BuildContext context) {
    
    return Container(child: ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index){
        return _buildReviewCard(context, reviews[index]);
      },
    ));
  }


  Widget _buildReviewCard(BuildContext context , Review review){
      return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black12,
          shape: BoxShape.rectangle,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             Text('Author: ${review.author.toUpperCase()}', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),),
             SizedBox(height: 20,),
             Text('Message: ${review.content}',style: TextStyle(fontSize: 13.0,  color: Colors.white),),
             SizedBox(height: 10,),
             
             
          ],
        ),
      );
  }
}

