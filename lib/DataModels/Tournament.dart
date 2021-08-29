class Tournament {

  String name,coverUrl,gameName,details,rules,game_icon_url;

  Tournament({
    this.name,
    this.coverUrl,
    this.gameName,
    this.details,
    this.rules,
    this.game_icon_url,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;


    Tournament tournament = Tournament(
      name: json['name'],
      coverUrl:  json['cover_url'],
      gameName:  json['game_name'],
      game_icon_url: json['game_icon_url'],
      details:  json['details'],
      rules:  json['rules'],
    );

    return tournament;
  }

}
