import 'package:bluestack_assignment/DataModels/NotificationDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepository {

  FirebaseFirestore firebaseFirestore;

  Future<List<NotificationDetail>> getNotifications(String token) async {


    if(firebaseFirestore==null)
      firebaseFirestore = FirebaseFirestore.instance;

    var response = await firebaseFirestore.collection("notifications").doc(token).collection("messages").get();


    if(response.docs.isNotEmpty){

      List<NotificationDetail> notifications = new List();

      for(QueryDocumentSnapshot<Map<String,dynamic>> snapshot in response.docs){

        NotificationDetail notificationDetail = NotificationDetail.fromJson(snapshot.data());

        notifications.add(notificationDetail);

      }

      return notifications;

    }
    else{

      throw Exception("No notifications yet");

    }

  }

}