import 'package:cinemax/util/constant.dart';
import 'package:cinemax/util/utility_helper.dart';
import 'package:flutter/material.dart';

class Sort extends StatefulWidget {
  final SortType selectedSortType;
  final Function callBack;

  const Sort({Key key, this.callBack, this.selectedSortType}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return SortState();
  }
}

class SortState extends State<Sort> {
  List<SortType> sortList;

  @override
  void initState() {
    sortList = getSortList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sort'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1.0, color: appTheme.accentColor)),
        child: ListView.builder(
          itemCount: sortList.length,
          itemBuilder: (context, index) {
            return buildTiles(sortList[index], context, index);
          },
        ),
      ),
    );
  }

  Widget buildTiles(SortType type, BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black),
            top: BorderSide(width: 1.0, color: Colors.black)),
      ),
      child: ListTile(
        title: Text(
          type.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
        trailing: widget.selectedSortType == sortList[index]
            ? Icon(
                Icons.check,
                color: Colors.lightBlueAccent,
              )
            : null,
        onTap: () {
          Navigator.pop(context);
          widget.callBack(sortList[index]);
        },
      ),
    );
  }
}
