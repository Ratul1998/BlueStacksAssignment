import 'package:bluestack_assignment/Bloc/notification_bloc/notification_bloc.dart';
import 'package:bluestack_assignment/Bloc/notification_bloc/notification_event.dart';
import 'package:bluestack_assignment/Bloc/notification_bloc/notification_state.dart';
import 'package:bluestack_assignment/Config/KeyStrings.dart';
import 'package:bluestack_assignment/Widgets/MyAppBar.dart';
import 'package:bluestack_assignment/Widgets/NavigationDrawer.dart';
import 'package:bluestack_assignment/Widgets/NotificationWidget.dart';
import 'package:bluestack_assignment/Widgets/loading_widget.dart';
import 'package:bluestack_assignment/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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

      appBar: MyAppBar(scaffoldKey: _scaffoldKey,appBarTitle: KeyStrings.notifications,),

      drawer: NavigationDrawer(username: widget.username,avatarUrl: widget.avatarUrl,overallRating: widget.overallRating,homePage: false,),

      body: SingleChildScrollView(

        controller: scrollController,

        child: BlocBuilder<NotificationBloc,NotificationState>(

          builder: (context,state){

            if(state is UnInitializedState){
              return LoadingWidget();
            }
            else if(state is NotificationLoadingState){

              if(state.notifications.isEmpty)
                return LoadingWidget();
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
            else if(state is NotificationLoadedState){

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
            else if(state is NotificationErrorState){
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

}