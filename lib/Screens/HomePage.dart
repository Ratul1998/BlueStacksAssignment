import 'package:bluestack_assignment/Config/KeyStrings.dart';
import 'package:bluestack_assignment/Providers/HomePageProvider.dart';
import 'package:bluestack_assignment/Screens/LanguageScreen.dart';
import 'package:bluestack_assignment/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/RecommendationList.dart';
import '../Widgets/UserDetails.dart';

class HomePage extends StatelessWidget {

  bool init = false;

  String userID;

  HomePage({this.userID});

  @override
  Widget build(BuildContext context) {

    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return ChangeNotifierProvider(
      lazy: false,
      create: (context)=>HomePageProvider(),

      child: Consumer<HomePageProvider> (

        builder: (BuildContext context, HomePageProvider value, Widget child){
          if(!init) {
            Provider.of<HomePageProvider>(context, listen: false).init(context,userID);
            init = true;
          }

          return Container(

            child: value.isDataLoaded ? Scaffold(

              key: _scaffoldKey,
              backgroundColor: Colors.white,

              drawer: Drawer(

                child:   ListView(

                  children: [

                    Stack(
                      children: [
                        Container(

                          padding: EdgeInsets.only(top: 32, bottom: 16),

                          color: Colors.black87,

                          child: UserAccountsDrawerHeader(

                            decoration: BoxDecoration(

                                color: Colors.transparent
                            ),


                            accountName: Text(value.userDetail != null ? value.userDetail.userName : " ", style: TextStyle(color: Colors.white),),

                            accountEmail: Text(value.userDetail != null ? value.userDetail.eloRating.toString() + " " + getTranslated(context, KeyStrings.eloRating) : " " , style: TextStyle(color: Colors.white),),

                            currentAccountPicture:
                            Container(

                              alignment: Alignment.center,

                              decoration: new BoxDecoration(
                                  border: Border.all(color: Colors.black54),
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(value.userDetail != null ? value.userDetail.profileUrl : " "),
                                  )
                              ),

                              child: Container() ,

                            ),

                          ),
                        ),
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>LanguageScreen(forLogin: false,)));
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
                        value.onLogOut();
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

              appBar: AppBar(

                centerTitle: true,
                title: Text(getTranslated(context, KeyStrings.appBarTitle), textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),
                backgroundColor: Colors.white, elevation: 0.0,
                leading: IconButton(
                  icon: Image.asset('assets/images/nav_bar_icon.png', height: 12,),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },

                ),
              ),

              body: Container(

                child: SingleChildScrollView(

                  controller: value.scrollController,

                  child: Column(

                    children: [

                      Container(

                          margin: EdgeInsets.symmetric(horizontal: 16.0),

                          child: UserDetails(userDetail: value.userDetail,value: value,)
                      ),

                      SizedBox(height: 16,),


                      Container(

                          margin: EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerLeft,

                          child: Text(getTranslated(context, KeyStrings.recommendedForYou),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),)
                      ),

                      SizedBox(height: 16,),

                      RecommendationList(tournaments:  value.recommendationsDetail.tournaments),

                      value.isListUpdating ? CircularProgressIndicator() : Container(),

                    ],
                  ),
                ),
              ),

            ) : Scaffold(body: Center(child: CircularProgressIndicator())),
          );

        },
      ),
    );
  }
}
