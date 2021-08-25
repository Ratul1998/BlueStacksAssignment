
import 'package:bluestack_assignment/DataModels/UserDetail.dart';

abstract class UserDetailState {}

class UninitializedState extends UserDetailState{}

class UserDetailLoadingState extends UserDetailState{}

class UserDetailLoadedState extends UserDetailState{

  UserDetail userDetail;

  UserDetailLoadedState({this.userDetail});

}

class UserDetailErrorState extends UserDetailState{

  String message;

  UserDetailErrorState({this.message});

}