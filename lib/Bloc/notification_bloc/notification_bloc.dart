import 'package:bluestack_assignment/Bloc/notification_bloc/notification_event.dart';
import 'package:bluestack_assignment/Bloc/notification_bloc/notification_state.dart';
import 'package:bluestack_assignment/Config/SharedPreferenceKey.dart';
import 'package:bluestack_assignment/DataModels/NotificationDetails.dart';
import 'package:bluestack_assignment/Repositories/firebase_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationBloc extends Bloc<NotificationEvent,NotificationState>{


  FirebaseRepository firebaseRepository;

  NotificationBloc({this.firebaseRepository}) : super(UnInitializedState());

  List<NotificationDetail> notifications = new List();


  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {

    if(event is FetchNotification){

      yield LoadingState(notifications: notifications);

      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

      String token = sharedPreferences.getString(SharedPreferenceKey.password);

      try{

        if(notifications.isEmpty)
          notifications = await firebaseRepository.getNotifications(token);
        else{

          List<NotificationDetail> temp = await firebaseRepository.getNextNotifications(token);

          if(temp!=null && temp.isNotEmpty)
            notifications.addAll(temp);

        }

        yield LoadedState(notifications: notifications);

      }
      catch(e){

        yield ErrorState(message: e.toString());

      }

    }

  }


}