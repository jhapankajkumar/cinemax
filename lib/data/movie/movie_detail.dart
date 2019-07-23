// To parse this JSON data, do
//
//     final movieDetail = movieDetailFromJson(jsonString);

import 'dart:convert';

import 'package:cinemax/data/genres.dart';
import 'package:cinemax/data/image/images.dart';

class MovieDetail {
    bool adult;
    String backdropPath;
    BelongsToCollection belongsToCollection;
    int budget;
    List<Genre> genres;
    String homepage;
    int id;
    String imdbId;
    String originalLanguage;
    String originalTitle;
    String overview;
    double popularity;
    String posterPath;
    DateTime releaseDate;
    int revenue;
    int runtime;
    String status;
    String tagline;
    String title;
    bool video;
    double voteAverage;
    int voteCount;
    Images images;

    MovieDetail({
        this.adult,
        this.backdropPath,
        this.belongsToCollection,
        this.budget,
        this.genres,
        this.homepage,
        this.id,
        this.imdbId,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.releaseDate,
        this.revenue,
        this.runtime,
        this.status,
        this.tagline,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount,
        this.images,
        
    });

    factory MovieDetail.fromJson(String str) => MovieDetail.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MovieDetail.fromMap(Map<String, dynamic> json) => new MovieDetail(
        adult: json["adult"] == null ? null : json["adult"],
        backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
        belongsToCollection: json["belongs_to_collection"] == null ? null : BelongsToCollection.fromMap(json["belongs_to_collection"]),
        budget: json["budget"] == null ? null : json["budget"],
        genres: json["genres"] == null ? null : new List<Genre>.from(json["genres"].map((x) => Genre.fromMap(x))),
        homepage: json["homepage"] == null ? null : json["homepage"],
        id: json["id"] == null ? null : json["id"],
        imdbId: json["imdb_id"] == null ? null : json["imdb_id"],
        originalLanguage: json["original_language"] == null ? null : json["original_language"],
        originalTitle: json["original_title"] == null ? null : json["original_title"],
        overview: json["overview"] == null ? null : json["overview"],
        popularity: json["popularity"] == null ? null : json["popularity"].toDouble(),
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        releaseDate: json["release_date"] == null ? null : (json["release_date"].toString().length == 0 ? DateTime.now() : DateTime.parse(json["release_date"])),
        revenue: json["revenue"] == null ? null : json["revenue"],
        runtime: json["runtime"] == null ? null : json["runtime"],
        status: json["status"] == null ? null : json["status"],
        tagline: json["tagline"] == null ? null : json["tagline"],
        title: json["title"] == null ? null : json["title"],
        video: json["video"] == null ? null : json["video"],
        voteAverage: json["vote_average"] == null ? null : json["vote_average"].toDouble(),
        voteCount: json["vote_count"] == null ? null : json["vote_count"],
        images: json["images"] == null ? null : Images.fromMap(json["images"]),
    );

    Map<String, dynamic> toMap() => {
        "adult": adult == null ? null : adult,
        "backdrop_path": backdropPath == null ? null : backdropPath,
        "belongs_to_collection": belongsToCollection == null ? null : belongsToCollection.toMap(),
        "budget": budget == null ? null : budget,
        "genres": genres == null ? null : new List<dynamic>.from(genres.map((x) => x.toMap())),
        "homepage": homepage == null ? null : homepage,
        "id": id == null ? null : id,
        "imdb_id": imdbId == null ? null : imdbId,
        "original_language": originalLanguage == null ? null : originalLanguage,
        "original_title": originalTitle == null ? null : originalTitle,
        "overview": overview == null ? null : overview,
        "popularity": popularity == null ? null : popularity,
        "poster_path": posterPath == null ? null : posterPath,
        "release_date": releaseDate == null ? null : "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "revenue": revenue == null ? null : revenue,
        "runtime": runtime == null ? null : runtime,
        "status": status == null ? null : status,
        "tagline": tagline == null ? null : tagline,
        "title": title == null ? null : title,
        "video": video == null ? null : video,
        "vote_average": voteAverage == null ? null : voteAverage,
        "vote_count": voteCount == null ? null : voteCount,
        "images": images == null ? null : images.toMap(),
    };
}

class BelongsToCollection {
    int id;
    String name;
    String posterPath;
    String backdropPath;

    BelongsToCollection({
        this.id,
        this.name,
        this.posterPath,
        this.backdropPath,
    });

    factory BelongsToCollection.fromJson(String str) => BelongsToCollection.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BelongsToCollection.fromMap(Map<String, dynamic> json) => new BelongsToCollection(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "poster_path": posterPath == null ? null : posterPath,
        "backdrop_path": backdropPath == null ? null : backdropPath,
    };
}


