import 'dart:convert';
class Video {
    String id;
    String iso6391;
    String iso31661;
    String key;
    String name;
    String site;
    int size;
    String type;

    Video({
        this.id,
        this.iso6391,
        this.iso31661,
        this.key,
        this.name,
        this.site,
        this.size,
        this.type,
    });

    factory Video.fromJson(String str) => Video.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Video.fromMap(Map<String, dynamic> json) =>  Video(
        id: json["id"] == null ? null : json["id"],
        iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
        iso31661: json["iso_3166_1"] == null ? null : json["iso_3166_1"],
        key: json["key"] == null ? null : json["key"],
        name: json["name"] == null ? null : json["name"],
        site: json["site"] == null ? null : json["site"],
        size: json["size"] == null ? null : json["size"],
        type: json["type"] == null ? null : json["type"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "iso_639_1": iso6391 == null ? null : iso6391,
        "iso_3166_1": iso31661 == null ? null : iso31661,
        "key": key == null ? null : key,
        "name": name == null ? null : name,
        "site": site == null ? null : site,
        "size": size == null ? null : size,
        "type": type == null ? null : type,
    };
}