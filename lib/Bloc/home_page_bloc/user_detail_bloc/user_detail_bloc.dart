import 'package:bluestack_assignment/Repositories/api_repository.dart';
import 'package:bluestack_assignment/Bloc/home_page_bloc/user_detail_bloc/user_detail_state.dart';
import 'package:bluestack_assignment/DataModels/UserDetail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_detail_event.dart';

class HomePageBloc extends Bloc<UserDetailEvent,UserDetailState>{

  ApiRepository apiRepository;

  String userId,token;

  UserDetail userDetail;

  HomePageBloc({this.apiRepository,this.userId,this.token}) : super(UninitializedState());



  @override
  Stream<UserDetailState> mapEventToState(UserDetailEvent event) async* {

    if(event is FetchingUserData){

      yield UserDetailLoadingState();

      try{
        userDetail = await apiRepository.getUserDetail(userId, token);
        yield UserDetailLoadedState(userDetail: userDetail);
      }
      catch(e){
        yield UserDetailErrorState(message: e.toString());
      }

    }

    else if(event is ChangeUserName){

      userDetail.username = event.userName;

      yield UserDetailLoadedState(userDetail: userDetail);

    }

    else if(event is UserTextFieldVisible){

      yield UserDetailLoadedState(userDetail: userDetail,isInEditMode: event.visible);

    }


  }



}