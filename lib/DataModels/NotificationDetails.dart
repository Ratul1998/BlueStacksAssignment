import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationDetail {

  String title;
  DateTime timestamp;

  NotificationDetail({this.title, this.timestamp});

  factory NotificationDetail.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;


    NotificationDetail notificationDetail = NotificationDetail(
      title: json['title'],
      timestamp:  (json['timestamp'] as Timestamp).toDate(),
    );

    return notificationDetail;
  }
}