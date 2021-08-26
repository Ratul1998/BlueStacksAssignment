class Tournament {

  String name,coverUrl,gameName,details,rules;
  DateTime startDate;

  Tournament({
    this.name,
    this.coverUrl,
    this.gameName,
    this.details,
    this.rules,
    this.startDate,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;


    Tournament tournament = Tournament(
      name: json['name'],
      coverUrl:  json['cover_url'],
      gameName:  json['game_name'],
      startDate: DateTime.fromMillisecondsSinceEpoch(int.parse(json['start_date'])),
      details:  json['details'],
      rules:  json['rules'],
    );

    return tournament;
  }

}
