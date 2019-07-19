import 'dart:convert';
class Images {
    List<Poster> backdrops;
    List<Poster> posters;

    Images({
        this.backdrops,
        this.posters,
    });

    factory Images.fromJson(String str) => Images.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Images.fromMap(Map<String, dynamic> json) => new Images(
        backdrops: json["backdrops"] == null ? null : new List<Poster>.from(json["backdrops"].map((x) => Poster.fromMap(x))),
        posters: json["posters"] == null ? null : new List<Poster>.from(json["posters"].map((x) => Poster.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "backdrops": backdrops == null ? null : new List<dynamic>.from(backdrops.map((x) => x.toMap())),
        "posters": posters == null ? null : new List<dynamic>.from(posters.map((x) => x.toMap())),
    };
}

class Poster {
    double aspectRatio;
    String filePath;
    int height;
    String iso6391;
    double voteAverage;
    int voteCount;
    int width;

    Poster({
        this.aspectRatio,
        this.filePath,
        this.height,
        this.iso6391,
        this.voteAverage,
        this.voteCount,
        this.width,
    });

    factory Poster.fromJson(String str) => Poster.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Poster.fromMap(Map<String, dynamic> json) => new Poster(
        aspectRatio: json["aspect_ratio"] == null ? null : json["aspect_ratio"].toDouble(),
        filePath: json["file_path"] == null ? null : json["file_path"],
        height: json["height"] == null ? null : json["height"],
        iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
        voteAverage: json["vote_average"] == null ? null : json["vote_average"].toDouble(),
        voteCount: json["vote_count"] == null ? null : json["vote_count"],
        width: json["width"] == null ? null : json["width"],
    );

    Map<String, dynamic> toMap() => {
        "aspect_ratio": aspectRatio == null ? null : aspectRatio,
        "file_path": filePath == null ? null : filePath,
        "height": height == null ? null : height,
        "iso_639_1": iso6391 == null ? null : iso6391,
        "vote_average": voteAverage == null ? null : voteAverage,
        "vote_count": voteCount == null ? null : voteCount,
        "width": width == null ? null : width,
    };
}