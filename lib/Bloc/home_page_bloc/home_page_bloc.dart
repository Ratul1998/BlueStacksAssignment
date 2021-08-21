import 'package:bluestack_assignment/Bloc/home_page_bloc/api_repository.dart';
import 'package:bluestack_assignment/Bloc/home_page_bloc/home_page_event.dart';
import 'package:bluestack_assignment/Bloc/home_page_bloc/home_page_state.dart';
import 'package:bluestack_assignment/DataModels/RecommendationsDetail.dart';
import 'package:bluestack_assignment/DataModels/UserDetail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBloc extends Bloc<HomePageEvent,HomePageState>{

  ApiRepository apiRepository;

  String userId,token;

  String cursor;

  RecommendationsDetail recommendationsDetail;

  UserDetail userDetail;

  HomePageBloc({this.apiRepository,this.userId,this.token}) : super(UninitializedState());



  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {

    if(event is FetchingData){

      yield LoadingState();

      try{
        userDetail = await apiRepository.getUserDetail(userId, token);
        recommendationsDetail = await apiRepository.getRecommendationDetails(10);
        cursor = recommendationsDetail.cursor;
        yield LoadedState(userDetail: userDetail,recommendationsDetail: recommendationsDetail);
      }
      catch(e){
        yield ErrorState(message: e.toString());
      }

    }

    if(event is ReFetchData){

      yield ReLoadingState(recommendationsDetail: recommendationsDetail,userDetail: userDetail);

      try{

        RecommendationsDetail temp = await apiRepository.getNextRecommendationDetails(10,cursor);

        cursor = temp.cursor;

        recommendationsDetail.tournaments.addAll(temp.tournaments);

        yield ReLoadedState(recommendationsDetail: recommendationsDetail,userDetail: userDetail);

      }
      catch(e){

        yield ErrorState(message: e.toString());

      }


    }

  }



}