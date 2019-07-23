import 'package:http/http.dart' as http;
import '../../util/url_constant.dart';


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

  Future getMovieGenreList() async {
    http.Response genereData = await http.get(kGenereMovieUrl);
    return genereData.body;
  }

  Future getVideoList(int movieId)async {
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

  Future getMovieListByGenre(int genreId, int pageNo) async {
    String url = getMovieUrlWithGenre(genreId, pageNo);
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
}
