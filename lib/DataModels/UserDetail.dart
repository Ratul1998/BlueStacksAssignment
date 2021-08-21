class UserDetail {

  final String username,userId,gender,highestRatingGamePkg,avatarUrl,user_handler,email,profile_url;

  final int matches_won,highest_rating,win_percentage,tournaments_played,matches_played,tournaments_won,current_level,current_xp,overall_rating;

  final bool favorite_games_selected;

  final List<String> favorite_games;

  UserDetail({this.username, this.userId, this.gender,
    this.highestRatingGamePkg, this.avatarUrl, this.user_handler,
    this.email, this.profile_url, this.matches_won, this.highest_rating,
    this.win_percentage, this.tournaments_played, this.matches_played,
    this.tournaments_won, this.current_level, this.current_xp,
    this.overall_rating, this.favorite_games_selected, this.favorite_games});


  factory UserDetail.factory(Map<String,dynamic> data) {

    if (data == null) return null;

    return UserDetail(

      username :  data['data']["username"] ,
      userId :  data['data']["user_id"] ,
      gender :  data['data']["gender"] ,
      highestRatingGamePkg :  data['data']["highest_rating_game_pkg"] ,
      avatarUrl :  data['data']["avatar_url"] ,
      user_handler :  data['data']["user_handler"] ,
      email :  data['data']["email"] ,
      profile_url :  data['data']["profile_url"] ,
      matches_won :  data['data']["matches_won"] ,
      highest_rating :  data['data']["highest_rating"] ,
      win_percentage :  data['data']["win_percentage"] ,
      tournaments_played :  data['data']["tournaments_played"] ,
      matches_played :  data['data']["matches_played"] ,
      tournaments_won :  data['data']["tournaments_won"] ,
      current_level :  data['data']["current_level"] ,
      current_xp :  data['data']["current_xp"] ,
      overall_rating :  data['data']["overall_rating"] ,
      favorite_games_selected :  data['data']["favorite_games_selected"] ,
      favorite_games: List<String>.from(
          data['data']['favorite_games'].map((x) => x.toString())),

    );
  }
}