// enum MovieListType<String> { 'Now Playing', 'TA', DE }


enum MovieListType{
      NowPaying,
      Upcoming,
      Popular,
      Trending,
      TopRated,
}

String getTextForEnum(MovieListType type) {
  switch (type) {
    case MovieListType.NowPaying:
      return 'Now Playing';
      break;
    case MovieListType.Upcoming:
      return 'Upcoming';
      break;
    case MovieListType.Popular:
      return 'Popular';
      break;
    case MovieListType.Trending:
      return 'Trending';
      break; 

    case MovieListType.TopRated:
      return 'Top Rated';
      break;  
      
      default:
      return '';
  }
}