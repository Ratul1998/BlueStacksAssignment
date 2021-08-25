import 'package:bluestack_assignment/DataModels/RecommendationsDetail.dart';
import 'package:bluestack_assignment/DataModels/UserDetail.dart';

abstract class HomePageState {}

class UninitializedState extends HomePageState{}

class LoadingState extends HomePageState{}

class LoadedState extends HomePageState{

  UserDetail userDetail;

  LoadedState({this.userDetail});

}

class ErrorState extends HomePageState{

  String message;

  ErrorState({this.message});

}