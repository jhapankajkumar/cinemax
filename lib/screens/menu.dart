import 'package:cinemax/data/genres.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final List<Genre> genres;

  const Menu({Key key, this.genres}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text("Genre"),
              automaticallyImplyLeading: false,
            ),
            ListView.builder(
              itemCount: genres.length,
              itemBuilder: (context, index) {
                return ListTile(
              title: Text(genres[index].name),
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => ManageProduct()));
              },
            );
              },
            ),
          ],
        ),
      );
  }
  
}