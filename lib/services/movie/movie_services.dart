import 'package:http/http.dart' as http;
import '../../util/url_constant.dart';
import 'dart:convert';

class MovieServices {
  
  Future getMovieList(String url, int pageNo) async {
    String finalUrl = '$url$pageNo';
    print(finalUrl);
    http.Response genereData = await http.get(finalUrl);
    return genereData.body;
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
}
