import 'package:bluestack_assignment/DataModels/RecommendationsDetail.dart';
import 'package:bluestack_assignment/DataModels/UserDetail.dart';

abstract class HomePageState {}

class UninitializedState extends HomePageState{}

class LoadingState extends HomePageState{}

class ReLoadingState extends HomePageState{

  RecommendationsDetail recommendationsDetail;

  UserDetail userDetail;

  ReLoadingState({this.userDetail,this.recommendationsDetail});

}

class LoadedState extends HomePageState{

  UserDetail userDetail;
  RecommendationsDetail recommendationsDetail;

  LoadedState({this.userDetail,this.recommendationsDetail});

}

class ReLoadedState extends HomePageState{

  RecommendationsDetail recommendationsDetail;

  UserDetail userDetail;

  ReLoadedState({this.userDetail,this.recommendationsDetail});

}

class ErrorState extends HomePageState{

  String message;

  ErrorState({this.message});

}