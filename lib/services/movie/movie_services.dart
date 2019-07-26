import 'dart:convert';

import 'package:cinemax/data/genres.dart';
import 'package:cinemax/data/movie/movie.dart';
import 'package:cinemax/data/movie/movies.dart';
import 'package:cinemax/services/network_manager.dart';
import 'package:cinemax/util/utility_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../util/url_constant.dart';


class MovieServices {
  NetworkManager networkManager = NetworkManager();

final JsonEncoder _encoder = new JsonEncoder();
  


  Future getMovieList(String url, int pageNo) async {
    
    
  }

  Future getMovieDetail(int movieId) async {
    String url = getDetailUrl(movieId);
    print(url);
    http.Response genereData = await http.get(url);
    return genereData.body;
  }

  Future getRelatedMovies(int movieId, int page) async {
    String url = getSimilarMovieUrl(movieId,page);
    print(url);
    http.Response genereData = await http.get(url);
    return genereData.body;
  }

  

  Future getVideoList(int movieId) async {
    String url = getVideoListUrl(movieId);
    print(url);
    http.Response genereData = await http.get(url);
    return genereData.body;
  }


  Future getCredits(int movieId)async {
    String url = getCreditsUrl(movieId);
    print(url);
    http.Response genereData = await http.get(url);
    return genereData.body;
  }

  Future getMovieReviews(int movieId, int pageNo)async {
    String url = getMovieReviewUrl(movieId, pageNo);
    print(url);
    http.Response genereData = await http.get(url);
    return genereData.body;
  }

  

  Future getSearchListFromText(String text, int pageNo) async {
    String url = getSearchUrl(text, pageNo);
    print(url);
    http.Response genereData = await http.get(url);
    return genereData.body;
  }

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
      print(result);
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
    print(url);
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
}
