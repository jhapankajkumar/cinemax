import 'dart:convert';

import 'package:cinemax/data/genres.dart';
import 'package:cinemax/data/movie/credits.dart';

import 'package:cinemax/data/movie/movie_detail.dart';
import 'package:cinemax/data/movie/movies.dart';
import 'package:cinemax/data/movie/reviews.dart';
import 'package:cinemax/data/video/videos.dart';
import 'package:cinemax/services/network_manager.dart';
import '../../util/url_constant.dart';


class MovieServices {
  NetworkManager networkManager = NetworkManager();

final JsonEncoder _encoder = new JsonEncoder();
  

  //Fetch method to get movie list
  Future<Movies> fetchMovieList(String url, int pageNo) async {
    String finalUrl = '$url$pageNo';
    // print(finalUrl);
    return networkManager.get(finalUrl).then((dynamic result){
      if (result['results'] != null ) {
        String body = _encoder.convert(result);
        return Movies.fromJson(body);
      }
      else {
        throw new Exception({'error': true, 'message': 'Failed to fetch the data'});
      }
    }).catchError((onError){
         throw new Exception({'error': true, 'message': 'Failed to fetch the data'});
    });
  }

  //Fetch method to get the genre list
  Future<Genres> fetchMovieGenreList() async {
    return networkManager.get(kGenereMovieUrl).then(( dynamic result){
      // print(result);
        if (result['genres'] != null ) {
        String body = _encoder.convert(result);
        return Genres.fromJson(body);
      }
      else {
        throw new Exception({'error': true, 'message': 'Failed to fetch the data'});
      }
    }).catchError((e){
      print(e);
        // throw new Exception({'error': true, 'message': 'Failed to fetch the data'});
    });
  }
  //Method to fetch movie list by genre
  Future<Movies> getMovieListByGenre(int genreId, int pageNo) async {
    String url = getMovieUrlWithGenre(genreId, pageNo);
    // print(url);
    // print(finalUrl);
    return networkManager.get(url).then((dynamic result){
      if (result['results'] != null ) {
        String body = _encoder.convert(result);
        return Movies.fromJson(body);
      }
      else {
        throw new Exception({'error': true, 'message': 'Failed to fetch the data'});
      }
    }).catchError((onError){
         throw new Exception({'error': true, 'message': 'Failed to fetch the data'});
    });
  }

//Method to fetch the movie detail
  Future<MovieDetail> fetchMovieDetailWithId(int movieId) async {
    String url = getDetailUrl(movieId);
    // print(url);
    return networkManager.get(url).then((dynamic result){
      if (result != null ) {
        String body = _encoder.convert(result);
        return MovieDetail.fromJson(body);
      }
      else {
        throw new Exception({'error': true, 'message': 'Failed to fetch the data'});
      }
    }).catchError((onError){
         throw new Exception({'error': true, 'message': 'Failed to fetch the data'});
    });
  }

//Method to get similart type of movie
  Future<Movies> fetchRelatedMovies(int movieId, int page) async {
    String url = getSimilarMovieUrl(movieId,page);
    // print(url);
    return networkManager.get(url).then((dynamic result){
      if (result['results'] != null ) {
        String body = _encoder.convert(result);
        return Movies.fromJson(body);
      }
      else {
        throw new Exception({'error': true, 'message': 'Failed to fetch the data'});
      }
    }).catchError((onError){
         throw new Exception({'error': true, 'message': 'Failed to fetch the data'});
    });
  }


  //Method to get video list
  Future<Videos> fetchVideoList(int movieId) async {
    String url = getVideoListUrl(movieId);
    // print(url);
    return networkManager.get(url).then((dynamic result){
      if (result['results'] != null ) {
        String body = _encoder.convert(result);
        return Videos.fromJson(body);
      }
      else {
        throw new Exception({'error': true, 'message': 'Failed to fetch the data'});
      }
    }).catchError((onError){
         throw new Exception({'error': true, 'message': 'Failed to fetch the data'});
    });
  }

//Method to fetch cast and crew
   Future<Credits> fetchCredits(int movieId)async {
    String url = getCreditsUrl(movieId);
    // print(url);
    return networkManager.get(url).then((dynamic result){
      if (result != null ) {  
        String body = _encoder.convert(result);
        return Credits.fromJson(body);
      }
      else {
        throw new Exception({'error': true, 'message': 'Failed to fetch the data'});
      }
    }).catchError((onError){
         throw new Exception({'error': true, 'message': 'Failed to fetch the data'});
    });
  }

 //Method to fetch the movie reviews 
   Future<Reviews> fetchMovieReviews(int movieId, int pageNo)async {
    String url = getMovieReviewUrl(movieId, pageNo);
    // print(url);
    return networkManager.get(url).then((dynamic result){
      if (result['results'] != null ) {
        String body = _encoder.convert(result);
        return Reviews.fromJson(body);
      }
      else {
        throw new Exception({'error': true, 'message': 'Failed to fetch the data'});
      }
    }).catchError((onError){
         throw new Exception({'error': true, 'message': 'Failed to fetch the data'});
    });
  }

  //Method to search movie by text
  Future<Movies> fetchSearchListFromText(String text, int pageNo) async {
    String url = getSearchUrl(text, pageNo);
    
    return networkManager.get(url).then((dynamic result){
      if (result['results'] != null ) {
        String body = _encoder.convert(result);
        return Movies.fromJson(body);
      }
      else {
        throw new Exception({'error': true, 'message': 'Failed to fetch the data'});
      }
    }).catchError((onError){
         throw new Exception({'error': true, 'message': 'Failed to fetch the data'});
    });
  }
}
