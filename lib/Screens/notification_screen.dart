import 'package:bluestack_assignment/Config/KeyStrings.dart';
import 'package:bluestack_assignment/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../routes.dart';


class Notifications extends StatelessWidget{


  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

      body: SingleChildScrollView(),

    );

  }



}