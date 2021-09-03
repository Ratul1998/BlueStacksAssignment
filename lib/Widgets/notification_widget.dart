import 'dart:math';

import 'package:bluestack_assignment/DataModels/NotificationDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget{

  NotificationDetail notificationDetail;

  NotificationWidget({this.notificationDetail});

  @override
  Widget build(BuildContext context) {

    return Container(

      height: 108,

      margin: EdgeInsets.symmetric(vertical: 12,horizontal: 8),
      
      padding: EdgeInsets.all(12),

      decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(24),

          color: Theme.of(context).cardColor,

          boxShadow: [ BoxShadow(

              color: Theme.of(context).shadowColor,
              blurRadius: 7,
              spreadRadius: 0,
              offset: Offset(0, 3),

          )]

      ),

      child: Column(


        children: [

          Row(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Container(

                width: 56,
                height: 56,

                alignment: Alignment.center,

                decoration: BoxDecoration(

                  shape: BoxShape.circle,

                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)],

                ),

                child: Text(notificationDetail.title.substring(0,1).toUpperCase(),style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w400),),

              ),

              Expanded(

                child: Container(

                  margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

                  child: Text(notificationDetail.title, style: Theme.of(context).textTheme.subtitle1,maxLines: 3,overflow: TextOverflow.ellipsis,),

                ),
              ),

            ],

          ),

          Expanded(
            child: Container(

              margin: EdgeInsets.only(top: 4,left: 16),

              alignment: Alignment.bottomRight,

              child: Text(diffInTime(notificationDetail.timestamp), style : TextStyle(fontSize: 12,color: Colors.grey[400],)),

            ),
          ),

        ],

      ),

    );

  }

  String diffInTime(DateTime date){

    int min = DateTime.now().difference(date).inMinutes;
    int hours = DateTime.now().difference(date).inHours;
    int days = DateTime.now().difference(date).inDays;

    if(min < 2){
      return "Just Now";
    }
    else{

      if(min < 60){

        return "$min minutes ago";

      }
      else{

        if(hours < 24){

          return "$hours hours ago";

        }
        else{

          return "$days days ago";

        }

      }

    }

  }

}