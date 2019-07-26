import 'package:cinemax/data/genres.dart';
import 'package:cinemax/services/movie/movie_services.dart';
import 'package:cinemax/util/constant.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  final List<Genre> genres;
  final int selectedIndex;
  final Function selectionCallback;

  const Menu({Key key, this.genres, this.selectedIndex, this.selectionCallback})
      : super(key: key);

  State<StatefulWidget> createState() {
    return MenuState();
  }
}

class MenuState extends State<Menu> {
  List<Genre>activeGenres;
  @override
  void initState() {
      if(widget.genres.length == 0) {
          _getGenreList();
      }
      else {
        activeGenres = widget.genres;
      }
    super.initState();
  }

  _getGenreList() async{
    await MovieServices().fetchMovieGenreList().then((result){
      setState(() {
        activeGenres =  result.genres;
      });
    }).catchError((onError){

    });

  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 1,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: appTheme.accentColor,
                    width: 1.0,
                  ),
                ),
              ),
              child: ListTile(
                title: Text(
                  'Home',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  widget.selectionCallback(-1, context);
                },
              ),
            );
          }
          return activeGenres != null ?  ExpandableListView(
            title: "Genre",
            genres: activeGenres,
            selectionCallback: widget.selectionCallback,
            selectedIndex: widget.selectedIndex,
          ):Container();
        },
        itemCount: 2,
      ), //_customeScrollView(context),
    );
  }
  
}

class ExpandableListView extends StatefulWidget {
  final String title;
  final List<Genre> genres;
  final Function selectionCallback;
  final int selectedIndex;

  const ExpandableListView(
      {Key key,
      this.title,
      this.genres,
      this.selectionCallback,
      this.selectedIndex})
      : super(key: key);

  @override
  _ExpandableListViewState createState() => _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableListView> {
  bool expandFlag = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                // IconButton(
                //     icon: Container(
                //       height: 50.0,
                //       width: 50.0,
                //       decoration: BoxDecoration(
                //         color: appTheme.accentColor,
                //         shape: BoxShape.circle,
                //       ),
                //       child: Center(
                //         child: Icon(
                //           expandFlag
                //               ? Icons.keyboard_arrow_up
                //               : Icons.keyboard_arrow_down,
                //           color: Colors.white,
                //           size: 30.0,
                //         ),
                //       ),
                //     ),
                //     onPressed: () {
                //       setState(() {
                //         expandFlag = !expandFlag;
                //       });
                //     }),
              ],
            ),
          ),
          ExpandableContainer(
              expanded: expandFlag,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: appTheme.accentColor,
                            width: 1.0,
                          ),
                          bottom: BorderSide(
                            color: appTheme.accentColor,
                            width: 1.0,
                          ),
                        ),
                        color: Color.fromARGB(255, 40, 40, 40)),
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        widget.selectionCallback(index, context);
                      },
                      title: Text(
                        widget.genres[index].name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: widget.selectedIndex == index
                                ? Colors.lightBlueAccent
                                : Colors.white),
                      ),
                    ),
                  );
                },
                itemCount: widget.genres.length,
              ))
        ],
      ),
    );
  }
}

class ExpandableContainer extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget child;

  ExpandableContainer({
    @required this.child,
    this.collapsedHeight = 0.0,
    this.expandedHeight = 500.0,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: MediaQuery.of(context).size.height - 200,
      child: Container(
        child: child,
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.transparent)),
      ),
    );
  }
}
