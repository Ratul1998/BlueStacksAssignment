import 'package:bluestack_assignment/Config/KeyStrings.dart';
import 'package:bluestack_assignment/DataModels/NotificationDetails.dart';
import 'package:bluestack_assignment/Widgets/NotificationWidget.dart';
import 'package:bluestack_assignment/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../routes.dart';


class Notifications extends StatelessWidget{


  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<NotificationDetail> notifications = [

    new NotificationDetail(title: "bulabul's Brawl Stars tournament Jun 11, 2021 08:52:00", timestamp: DateTime.now()),
    new NotificationDetail(title: "Match results for bulabul's Brawl Stars tournament Jun 11, 2021 08:52:00 updated" , timestamp: DateTime(2021,8,22,10,30)),
    new NotificationDetail(title: "Match results for bulabul's Brawl Stars tournament Jun 11, 2021 08:52:00 updated", timestamp: DateTime(2021,8,22,7,30)),
    new NotificationDetail(title: "Lookup your team for NishaGuptaTwitter's Free Fire tournament Oct 08, 2020 13:05:00.", timestamp: DateTime(2021,8,21,19,30)),
    new NotificationDetail(title: "Your user profile has been updated with your new rating of 816 for Brawl Stars. Congratulations on your win", timestamp: DateTime(2021,8,18,7,30)),

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      key: _scaffoldKey,

      appBar: AppBar(

        centerTitle: true,
        title: Text(getTranslated(context, KeyStrings.notifications), textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white, elevation: 0.0,
        leading: IconButton(
          icon: Image.asset('assets/images/nav_bar_icon.png', height: 12,),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },

        ),

      ),

      drawer: Drawer(

        child: ListView(

          children: [

            ListTile(
              onTap: () {
                Navigator.pushNamed(context,Routes.changeLanguage);
              },
              leading: Icon(
                Icons.language,
                size: 30,
                color: Colors.black,
              ),
              title: Text(getTranslated(context, KeyStrings.changeLanguage)),
            ),

            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              leading: Icon(
                Icons.home,
                size: 30,
                color: Colors.black,
              ),
              title: Text(getTranslated(context, KeyStrings.goToHome)),
            ),

            ListTile(
              onTap: () {

              },
              leading: Icon(
                Icons.logout,
                size: 30,
                color: Colors.black,
              ),
              title: Text(getTranslated(context, KeyStrings.logOut)),
            )

          ],

        ),

      ),

      body: ListView.builder(
        itemCount: notifications.length,
        padding: EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) {
          return NotificationWidget(notificationDetail: notifications.elementAt(index),);
        },
      ),

    );

  }



}