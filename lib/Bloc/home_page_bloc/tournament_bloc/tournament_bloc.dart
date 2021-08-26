import 'package:bluestack_assignment/Bloc/home_page_bloc/tournament_bloc/tournament_event.dart';
import 'package:bluestack_assignment/Bloc/home_page_bloc/tournament_bloc/tournament_state.dart';
import 'package:bluestack_assignment/DataModels/RecommendationsDetail.dart';
import 'package:bluestack_assignment/Repositories/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TournamentBloc extends Bloc<TournamentEvent,TournamentState> {

  ApiRepository apiRepository;

  RecommendationsDetail recommendationsDetail;

  String cursor;

  TournamentBloc({this.apiRepository}) : super(UnInitializedState());

  @override
  Stream<TournamentState> mapEventToState(TournamentEvent event)  async* {

    if(event is FetchTournamentData){

      yield TournamentLoadingState(recommendationsDetail: recommendationsDetail);

      try{

        if(recommendationsDetail == null){

          recommendationsDetail = await apiRepository.getRecommendationDetails(10);
          cursor = recommendationsDetail.cursor;
          yield TournamentLoadedState(recommendationsDetail: recommendationsDetail,cursor: cursor);

        }
        else{

          RecommendationsDetail temp = await apiRepository.getNextRecommendationDetails(10,cursor);

          cursor = temp.cursor;

          recommendationsDetail.tournaments.addAll(temp.tournaments);

          yield TournamentLoadedState(recommendationsDetail: recommendationsDetail,cursor: cursor);

        }

      }
      catch(e){

        yield TournamentErrorState(message: e.toString());

      }



    }


  }





}