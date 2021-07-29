class Tournament {

  String name;
  String coverUrl;
  String gameName;

  Tournament({
    this.name,
    this.coverUrl,
    this.gameName,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;


    Tournament tournament = Tournament(
      name: json['name'],
      coverUrl:  json['cover_url'],
      gameName:  json['game_name'],
    );

    return tournament;
  }

}
