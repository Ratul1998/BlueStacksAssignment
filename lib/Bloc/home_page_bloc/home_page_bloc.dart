import 'package:bluestack_assignment/Bloc/home_page_bloc/api_repository.dart';
import 'package:bluestack_assignment/Bloc/home_page_bloc/home_page_event.dart';
import 'package:bluestack_assignment/Bloc/home_page_bloc/home_page_state.dart';
import 'package:bluestack_assignment/DataModels/UserDetail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBloc extends Bloc<HomePageEvent,HomePageState>{

  ApiRepository apiRepository;

  String userId,token;

  HomePageBloc({this.apiRepository,this.userId,this.token}) : super(UninitializedState());



  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {

    if(event is FetchingData){

      yield LoadingState();

      try{
        UserDetail userDetail = await apiRepository.getUserDetail(userId, token);
        yield LoadedState(userDetail: userDetail);
      }
      catch(e){
        yield ErrorState(message: e.toString());
      }

    }

  }



}