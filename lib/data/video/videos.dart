import 'dart:convert';

import 'package:cinemax/data/video/video.dart';
class Videos {
    List<Video> results;

    Videos({
        this.results,
    });

    factory Videos.fromJson(String str) => Videos.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Videos.fromMap(Map<String, dynamic> json) =>  Videos(
        results: json["results"] == null ? null : List<Video>.from(json["results"].map((x) => Video.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "results": results == null ? null :  List<dynamic>.from(results.map((x) => x.toMap())),
    };
}