class UserDetail {

  String userName = "" ;
  String profileUrl  = "";
  int eloRating;
  int totalTournamentCount;
  int tournamentWon;

  UserDetail(
      {this.userName,
      this.profileUrl,
      this.eloRating,
      this.totalTournamentCount,
      this.tournamentWon});

  factory UserDetail.factory(Map<String,dynamic> data) {

    if (data == null) return null;

    return UserDetail(

      userName :  data["userName"] ,
      profileUrl :  data["profileUrl"] ,
      eloRating :  data["eloRating"] ,
      totalTournamentCount :  data["totalTournamentCount"] ,
      tournamentWon :  data["tournamentWon"] ,

    );
  }
}