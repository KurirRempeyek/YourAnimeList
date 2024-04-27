class Anime {
  late int? id;
  late String title;
  //late String status;
  //late int progress;
  //late double? score;

  Anime(this.id, this.title); //this.status, this.progress, this.score);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'title': title,
      //'status': status,
      //'progress': progress,
      //'score': score,
    };
    return map;
  }

  Anime.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    //status = map['status'];
    //progress = map['progress'];
    //score = map['score'];
  }
}
