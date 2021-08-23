import 'package:bluestack_assignment/Bloc/notification_bloc/notification_bloc.dart';
import 'package:bluestack_assignment/Bloc/notification_bloc/notification_event.dart';
import 'package:bluestack_assignment/Bloc/notification_bloc/notification_state.dart';
import 'package:bluestack_assignment/Config/KeyStrings.dart';
import 'package:bluestack_assignment/Config/SharedPreferenceKey.dart';
import 'package:bluestack_assignment/Widgets/NotificationWidget.dart';
import 'package:bluestack_assignment/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes.dart';


class Notifications extends StatefulWidget{

  String username, avatarUrl;
  int overallRating;

  Notifications({this.username,this.avatarUrl,this.overallRating});

  @override
  NotifyState createState() => NotifyState();
}

class NotifyState extends State<Notifications>{

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  NotificationBloc notificationBloc;

  ScrollController scrollController = ScrollController();

  bool init = false;

  @override
  void initState() {
    super.initState();

    notificationBloc = BlocProvider.of<NotificationBloc>(context);

    notificationBloc.add(FetchNotification());

    scrollController.addListener(() async {

      if(scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {

        if(!init){

          notificationBloc.add(FetchNotification());
          init = true;

        }

      }

    });

  }

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

            Stack(
              children: [

                drawerData(),
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

                onLogOut();

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

      body: SingleChildScrollView(

        controller: scrollController,

        child: BlocBuilder<NotificationBloc,NotificationState>(

          builder: (context,state){

            if(state is UnInitializedState){
              return Center(child: CircularProgressIndicator(),);
            }
            else if(state is LoadingState){

              if(state.notifications.isEmpty)
                return Center(child: CircularProgressIndicator(),);
              else
                return Column(

                  children: [

                    ListView.builder(
                      itemCount: state.notifications.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      itemBuilder: (context, index) {
                        return NotificationWidget(notificationDetail: state.notifications.elementAt(index),);
                      },
                    ),

                    CircularProgressIndicator(),

                  ],

                );
            }
            else if(state is LoadedState){

              init = false;

              return Column(
                children: [
                  ListView.builder(
                    itemCount: state.notifications.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    itemBuilder: (context, index) {
                      return NotificationWidget(notificationDetail: state.notifications.elementAt(index),);
                    },
                  ),
                ],
              );


            }
            else if(state is ErrorState){
              return Center(child: Text(state.message),);
            }
            else{
              return Container();
            }


          },

        ),
      ),

    );

  }

  Widget drawerData(){

    return Container(

      padding: EdgeInsets.only(top: 32, bottom: 16),

      color: Colors.black87,

      child: UserAccountsDrawerHeader(

        decoration: BoxDecoration(

            color: Colors.transparent
        ),


        accountName: Text(widget.username, style: TextStyle(color: Colors.white),),

        accountEmail: Text(widget.overallRating.toString() + " " + getTranslated(context, KeyStrings.eloRating)  , style: TextStyle(color: Colors.white),),

        currentAccountPicture:
        Container(

          alignment: Alignment.center,

          decoration: new BoxDecoration(
              border: Border.all(color: Colors.black54),
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(widget.avatarUrl),
              )
          ),

          child: Container() ,

        ),

      ),
    );

  }

  void onLogOut() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(SharedPreferenceKey.userName);
    sharedPreferences.remove(SharedPreferenceKey.password);
    Navigator.pushNamedAndRemoveUntil(context, Routes.login, (r) => false);
  }


}