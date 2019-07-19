


const String kApiKey = '5995e5e4189d1d0e964e3330aa5b134c';

const String kAccessToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1OTk1ZTVlNDE4OWQxZDBlOTY0ZTMzMzBhYTViMTM0YyIsInN1YiI6IjVkMmFiOGM3YTI5NGYwMjg0NjJkOWUzYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ._L7-GNm5o5Aq3yb4Fv_38a30aPxFYA_uoovOmBJzEgk';

const String kBaseUrl = 'https://api.themoviedb.org/3';

const String kRequestTokenUrl = '$kBaseUrl/authentication/token/new?api_key=$kApiKey'; 

const String kGenereMovieUrl = '$kBaseUrl/genre/movie/list?api_key=$kApiKey';
const String kGenereTVUrl = '$kBaseUrl/genre/tv/list?api_key=$kApiKey';

//Movie List
//Now Playing
const String kNowPaylingMovieUrl = '$kBaseUrl/movie/now_playing?api_key=$kApiKey&page=';
//Top Rated
const String kTopRatedMovieUrl = '$kBaseUrl/movie/top_rated?api_key=$kApiKey&page=';
//Popular
const String kPopularMovieUrl = '$kBaseUrl/movie/popular?api_key=$kApiKey&page=';
//Upcoming
const String kUpcomingMovieUrl = '$kBaseUrl/movie/upcoming?api_key=$kApiKey&page=';


//Movie Detail

const String kPosterImageBaseUrl = 'http://image.tmdb.org/t/p/';
//"w92", "w154", "w185", "w342", "w500", "w780"

String getDetailUrl(int movieId) {
  var url = '$kBaseUrl/movie/$movieId?api_key=$kApiKey&append_to_response=videos';
  return url;
}


String getSimilarMovieUrl(int movieId, int pageNo) {
  var url = '$kBaseUrl/movie/$movieId/similar?api_key=$kApiKey&page=$pageNo';
  return url;
}



//a33b1787ab28a5b8ed06cfda0668ca5a40e77379
