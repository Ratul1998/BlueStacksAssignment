import 'package:bluestack_assignment/DataModels/NotificationDetails.dart';

abstract class NotificationState{}

class UnInitializedState extends NotificationState{}

class NotificationLoadingState extends NotificationState{

  List<NotificationDetail> notifications;

  NotificationLoadingState({this.notifications});

}

class NotificationLoadedState extends NotificationState{

  List<NotificationDetail> notifications;

  NotificationLoadedState({this.notifications});


}

class NotificationErrorState extends NotificationState{

  String message;

  NotificationErrorState({this.message});

}