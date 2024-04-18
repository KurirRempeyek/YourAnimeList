class Anime {
  late int? id;
  late String title;
  Anime(this.id, this.title);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'title': title,
    };
    return map;
  }

  Anime.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
  }
}
