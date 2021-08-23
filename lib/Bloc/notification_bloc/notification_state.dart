import 'package:bluestack_assignment/DataModels/NotificationDetails.dart';

abstract class NotificationState{}

class UnInitializedState extends NotificationState{}

class LoadingState extends NotificationState{

  List<NotificationDetail> notifications;

  LoadingState({this.notifications});

}

class LoadedState extends NotificationState{

  List<NotificationDetail> notifications;

  LoadedState({this.notifications});


}

class ErrorState extends NotificationState{

  String message;

  ErrorState({this.message});

}