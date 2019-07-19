// To parse this JSON data, do
//
//     final movies = moviesFromJson(jsonString);

import 'dart:convert';
import 'package:cinemax/data/movie/movie.dart';

class Movies {
    List<Movie> results;
    int page;
    int totalResults;
    Dates dates;
    int totalPages;

    Movies({
        this.results,
        this.page,
        this.totalResults,
        this.dates,
        this.totalPages,
    });

    factory Movies.fromJson(String str) => Movies.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Movies.fromMap(Map<String, dynamic> json) =>  Movies(
        results: json["results"] == null ? null :  List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        page: json["page"] == null ? null : json["page"],
        totalResults: json["total_results"] == null ? null : json["total_results"],
        dates: json["dates"] == null ? null : Dates.fromMap(json["dates"]),
        totalPages: json["total_pages"] == null ? null : json["total_pages"],
    );

    Map<String, dynamic> toMap() => {
        "results": results == null ? null :  List<dynamic>.from(results.map((x) => x.toMap())),
        "page": page == null ? null : page,
        "total_results": totalResults == null ? null : totalResults,
        "dates": dates == null ? null : dates.toMap(),
        "total_pages": totalPages == null ? null : totalPages,
    };
}

class Dates {
    DateTime maximum;
    DateTime minimum;

    Dates({
        this.maximum,
        this.minimum,
    });

    factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Dates.fromMap(Map<String, dynamic> json) =>  Dates(
        maximum: json["maximum"] == null ? null : DateTime.parse(json["maximum"]),
        minimum: json["minimum"] == null ? null : DateTime.parse(json["minimum"]),
    );

    Map<String, dynamic> toMap() => {
        "maximum": maximum == null ? null : "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum": minimum == null ? null : "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
    };
}


