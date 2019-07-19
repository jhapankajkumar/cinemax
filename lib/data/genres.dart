import 'dart:convert';

class Genres {
    List<Genre> genres;

    Genres({
        this.genres,
    });

    factory Genres.fromJson(String str) => Genres.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Genres.fromMap(Map<String, dynamic> json) => new Genres(
        genres: json["genres"] == null ? null : new List<Genre>.from(json["genres"].map((x) => Genre.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "genres": genres == null ? null : new List<dynamic>.from(genres.map((x) => x.toMap())),
    };
}

class Genre {
    int id;
    String name;

    Genre({
        this.id,
        this.name,
    });

    factory Genre.fromJson(String str) => Genre.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Genre.fromMap(Map<String, dynamic> json) => new Genre(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
    };
}