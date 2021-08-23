import 'package:bluestack_assignment/DataModels/NotificationDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepository {

  FirebaseFirestore firebaseFirestore;

  var notificationData = {

    {
      "payload":
      {
        "notification":
        {
          "subtitle": "",
          "title": "Your new Free Fire rating is 800. Thank you for playing in tavs's Free Fire tournament Nov 06, 2020 16:46:00"
        },

        "silent_notification": false,

        "extra_data":
        {
          "game_id": "-free-fire"
        },
        "tournament_name": "tavs's Free Fire tournament Nov 06, 2020 16:46:00",
        "subtitle": "",
        "icon": "speaker",
        "text": "",
        "title": "Your new Free Fire rating is 800. Thank you for playing in tavs's Free Fire tournament Nov 06, 2020 16:46:00",
        "config":
        {
          "border":
          {
            "color": ""
          },
          "feed": false,
          "nav_to": "user_profile",
          "bg":
          {
            "color": ""
          },
          "is_silent": false,
          "notifications": true
        },
        "tournament_id": "1592a481c70c4974bdd1872ed264f989"
      },
      "event": "ratings_updated",
      "seen": false,
      "timestamp": DateTime.now()
    }

  };

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