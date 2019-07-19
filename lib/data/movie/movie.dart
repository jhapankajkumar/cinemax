import 'dart:convert';
class Movie {
    int voteCount;
    int id;
    bool video;
    double voteAverage;
    String title;
    double popularity;
    String posterPath;
    OriginalLanguage originalLanguage;
    String originalTitle;
    List<int> genreIds;
    String backdropPath;
    bool adult;
    String overview;
    DateTime releaseDate;

    Movie({
        this.voteCount,
        this.id,
        this.video,
        this.voteAverage,
        this.title,
        this.popularity,
        this.posterPath,
        this.originalLanguage,
        this.originalTitle,
        this.genreIds,
        this.backdropPath,
        this.adult,
        this.overview,
        this.releaseDate,
    });

    factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Movie.fromMap(Map<String, dynamic> json) =>  Movie(
        voteCount: json["vote_count"] == null ? null : json["vote_count"],
        id: json["id"] == null ? null : json["id"],
        video: json["video"] == null ? null : json["video"],
        voteAverage: json["vote_average"] == null ? null : json["vote_average"].toDouble(),
        title: json["title"] == null ? null : json["title"],
        popularity: json["popularity"] == null ? null : json["popularity"].toDouble(),
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        originalLanguage: json["original_language"] == null ? null : originalLanguageValues.map[json["original_language"]],
        originalTitle: json["original_title"] == null ? null : json["original_title"],
        genreIds: json["genre_ids"] == null ? null :  List<int>.from(json["genre_ids"].map((x) => x)),
        backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
        adult: json["adult"] == null ? null : json["adult"],
        overview: json["overview"] == null ? null : json["overview"],
        releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    );

    Map<String, dynamic> toMap() => {
        "vote_count": voteCount == null ? null : voteCount,
        "id": id == null ? null : id,
        "video": video == null ? null : video,
        "vote_average": voteAverage == null ? null : voteAverage,
        "title": title == null ? null : title,
        "popularity": popularity == null ? null : popularity,
        "poster_path": posterPath == null ? null : posterPath,
        "original_language": originalLanguage == null ? null : originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle == null ? null : originalTitle,
        "genre_ids": genreIds == null ? null :  List<dynamic>.from(genreIds.map((x) => x)),
        "backdrop_path": backdropPath == null ? null : backdropPath,
        "adult": adult == null ? null : adult,
        "overview": overview == null ? null : overview,
        "release_date": releaseDate == null ? null : "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    };
}

enum OriginalLanguage { EN, TA, DE }

final originalLanguageValues =  EnumValues({
    "de": OriginalLanguage.DE,
    "en": OriginalLanguage.EN,
    "ta": OriginalLanguage.TA
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) =>  MapEntry(v, k));
        }
        return reverseMap;
    }
}