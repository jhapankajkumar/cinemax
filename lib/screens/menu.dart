import 'package:cinemax/data/genres.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final List<Genre> genres;

  const Menu({Key key, this.genres}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 1,
      child:  Column(
        children: <Widget>[
          PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              title: Text("Genre"),
              automaticallyImplyLeading: false,
            ),
          ),
          Container(
            // color: Colors.green,
            child: Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(genres[index].name),
                        onTap: () {
                          Navigator.pop(context);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (BuildContext context) => ManageProduct()));
                        },
                      ),
                      Divider(
                        height: 3,
                        color: Colors.grey,
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget scrollView()
{
  return CustomScrollView(
  slivers: <Widget>[
     SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      expandedHeight: 250.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Demo'),
      ),
    ),
    SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 4.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.teal[100 * (index % 9)],
            child: Text('grid item $index'),
          );
        },
        childCount: 20,
      ),
    ),
    SliverFixedExtentList(
      itemExtent: 50.0,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.lightBlue[100 * (index % 9)],
            child: Text('list item $index'),
          );
        },
      ),
    ),
  ],
);
}