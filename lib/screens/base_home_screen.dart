import 'package:cinemax/data/genres.dart';
import 'package:cinemax/screens/home_screen.dart';
import 'package:cinemax/screens/menu.dart';
import 'package:cinemax/screens/movie_list_by_genre.dart';
import 'package:cinemax/services/movie/movie_services.dart';
import 'package:cinemax/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BaseHomeScreen extends StatefulWidget {
  final Widget body;
  final AppBar appBar;
  const BaseHomeScreen({Key key, this.body, this.appBar}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return BaseHomeScreenState();
  }
}

class BaseHomeScreenState extends State<BaseHomeScreen> {
  List<Genre> genreList;
  int selectedIndex;

  _genreSelected(int index, BuildContext context) {
    if (index == -1) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return HomeScreen(
          title: 'Cinemax',
        );
      }));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return GenreMovieListScreen(
          genre: genreList[index],
        );
      }));
    }
    print("Setting State");

    SharedDataManager().menuSelectedIndex = index;
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
    print("Index: ${SharedDataManager().menuSelectedIndex}");
    int index = SharedDataManager().menuSelectedIndex;
    return Scaffold(
      drawer: genreList == null
          ? Container()
          : Menu(
              genres: genreList,
              selectionCallback: _genreSelected,
              selectedIndex: index > 0 ? index : null,
            ),
      body: widget.body,
      appBar: widget.appBar,
    );
  }
}
