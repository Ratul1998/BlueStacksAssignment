import 'package:bluestack_assignment/DataModels/RecommendationsDetail.dart';

abstract class TournamentState{}

class UnInitializedState extends TournamentState{}

class TournamentLoadingState extends TournamentState{

  RecommendationsDetail recommendationsDetail;

  TournamentLoadingState({this.recommendationsDetail});


}

class TournamentLoadedState extends TournamentState{

  RecommendationsDetail recommendationsDetail;

  TournamentLoadedState({this.recommendationsDetail});

}

class TournamentErrorState extends TournamentState{

  String message;

  TournamentErrorState({this.message});

}