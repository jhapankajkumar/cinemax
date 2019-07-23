import 'package:cinemax/common_widgets/menu.dart';
import 'package:cinemax/data/genres.dart';
import 'package:cinemax/screens/home/home_screen.dart';
import 'package:cinemax/screens/movie_list/movie_list_by_genre.dart';
import 'package:cinemax/services/movie/movie_services.dart';
import 'package:cinemax/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BaseHomeScreen extends StatefulWidget {
  final Widget body;
  final Widget appBar;
  const BaseHomeScreen({Key key, this.body, this.appBar}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return BaseHomeScreenState();
  }
}

class BaseHomeScreenState extends State<BaseHomeScreen> {
  List<Genre> genreList;

  _genreSelected(int index, BuildContext context) {
    if (index == -1 && SharedDataManager().menuSelectedIndex != index) {
      SharedDataManager().menuSelectedIndex = index;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return HomeScreen(
          title: 'Cinemax',
        );
      }));
      SharedDataManager().menuSelectedIndex = index;
    } else if(SharedDataManager().menuSelectedIndex != index) {
      SharedDataManager().menuSelectedIndex = index;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return GenreMovieListScreen(
          genre: genreList[index],isFromDetail: false,
        );
      }));
    }
    
  }

  @override
  void initState() {
    _getGenrelist();
    super.initState();
  }

  _getGenrelist() async {
    var data = await MovieServices().getMovieGenreList();
    Genres list = Genres.fromJson(data);
    setState(() {
      genreList = list.genres;
    });
  }

  @override
  Widget build(BuildContext context) {
    int index = SharedDataManager().menuSelectedIndex;
    return Scaffold(
        drawer: genreList == null
            ? Container()
            : Menu(
                genres: genreList,
                selectionCallback: _genreSelected,
                selectedIndex: index >= 0 ? index : null,
              ),
        body: widget.body,
        appBar: widget.appBar);
  }
}
