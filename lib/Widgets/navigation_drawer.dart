import 'package:bluestack_assignment/Config/KeyStrings.dart';
import 'package:bluestack_assignment/Config/SharedPreferenceKey.dart';
import 'package:bluestack_assignment/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes.dart';

class NavigationDrawer extends StatelessWidget{


  String username, avatarUrl;
  int overallRating;

  bool homePage;

  NavigationDrawer({this.username,this.avatarUrl,this.overallRating,this.homePage});

  @override
  Widget build(BuildContext context) {

    return Drawer(

      child:   ListView(

        children: [

          Stack(
            children: [

              (username!=null) ? drawerData(context) : Container(height: 240,child: Center(child: CircularProgressIndicator(),),),

              Container(

                alignment: Alignment.bottomRight,

                child: Image.asset(
                  'assets/images/controller.png',
                  height: 120,
                  width: 120,
                  color: Colors.white.withOpacity(0.4),

                ),
              ),
            ],
          ),

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

          Visibility(

            visible: homePage,

            child: ListTile(
              onTap: () {

                if(username!=null)
                  goToNotifications(context);

              },
              leading: Icon(
                Icons.notifications,
                size: 30,
                color: Colors.black,
              ),
              title: Text(getTranslated(context, KeyStrings.notifications)),
            ),
          ),

          Visibility(

            visible: !homePage,

            child: ListTile(
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
          ),

          ListTile(
            onTap: () {
              onLogOut(context);
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
    );

  }


  Widget drawerData(BuildContext context){

    return Container(

      padding: EdgeInsets.only(top: 32, bottom: 16),

      color: Colors.black87,

      child: UserAccountsDrawerHeader(

        decoration: BoxDecoration(

            color: Colors.transparent
        ),


        accountName: Text(username, style: TextStyle(color: Colors.white),),

        accountEmail: Text(overallRating.toString() + " " + getTranslated(context, KeyStrings.eloRating)  , style: TextStyle(color: Colors.white),),

        currentAccountPicture:
        Container(

          alignment: Alignment.center,

          decoration: new BoxDecoration(
              border: Border.all(color: Colors.black54),
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(avatarUrl),
              )
          ),

          child: Container() ,

        ),

      ),
    );

  }

  void onLogOut(BuildContext context) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(SharedPreferenceKey.userName);
    sharedPreferences.remove(SharedPreferenceKey.password);
    Navigator.pushNamedAndRemoveUntil(context, Routes.login, (r) => false);
  }

  void goToNotifications(BuildContext context){

    var args = {

      "username":username,
      "avatarUrl":avatarUrl,
      "overallRating":overallRating,

    };

    Navigator.pop(context);
    Navigator.pushNamed(context, Routes.notifications,arguments: args);

  }

}