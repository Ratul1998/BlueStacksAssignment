import 'package:bluestack_assignment/Bloc/home_page_bloc/home_page_bloc.dart';
import 'package:bluestack_assignment/Bloc/home_page_bloc/home_page_event.dart';
import 'package:bluestack_assignment/Bloc/home_page_bloc/home_page_state.dart';
import 'package:bluestack_assignment/Config/KeyStrings.dart';
import 'package:bluestack_assignment/Config/SharedPreferenceKey.dart';
import 'package:bluestack_assignment/DataModels/RecommendationsDetail.dart';
import 'package:bluestack_assignment/DataModels/UserDetail.dart';
import 'package:bluestack_assignment/Widgets/favourite_game.dart';
import 'package:bluestack_assignment/localization/language_constants.dart';
import 'package:bluestack_assignment/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/RecommendationList.dart';
import '../Widgets/UserDetails.dart';
import 'LanguageScreen.dart';

class HomePage extends StatefulWidget {

  String userID;
  String token;


  HomePage({this.userID,this.token});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage>{

  HomePageBloc homePageBloc;

  bool init = false;

  ScrollController scrollController = ScrollController();

  UserDetail userDetail;

  @override
  void initState() {

    super.initState();

    homePageBloc = BlocProvider.of<HomePageBloc>(context);

    homePageBloc.add(FetchingData());

    scrollController.addListener(() async {

      if(scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {

        if(!init){

          homePageBloc.add(ReFetchData());
          init = true;

        }

      }

    });

  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: _scaffoldKey,
      backgroundColor: Colors.white,

      drawer: Drawer(

        child:   ListView(

          children: [

            Stack(
              children: [

                BlocBuilder<HomePageBloc,HomePageState>(

                  builder: (context,state){

                    if(state is UninitializedState){
                      return loadingWidget();
                    }
                    else if(state is LoadingState){
                      return loadingWidget();
                    }
                    else if (state is LoadedState){
                      this.userDetail = state.userDetail;
                      return drawerData(state.userDetail);
                    }
                    else if (state is ErrorState){
                      return Container();
                    }
                    else if (state is ReLoadedState){
                      return drawerData(state.userDetail);
                    }
                    else if (state is ReLoadingState){
                      return drawerData(state.userDetail);
                    }
                    else{
                      return Container();
                    }

                  },

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

                if(userDetail!=null){

                  var args = {

                    "username":userDetail.username,
                    "avatarUrl":userDetail.avatarUrl,
                    "overallRating":userDetail.overall_rating,

                  };

                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routes.notifications,arguments: args);

                }

              },
              leading: Icon(
                Icons.notifications,
                size: 30,
                color: Colors.black,
              ),
              title: Text(getTranslated(context, KeyStrings.notifications)),
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

      body: BlocBuilder<HomePageBloc,HomePageState>(

        builder: (context,state){

          if(state is UninitializedState){
            return loadingWidget();
          }
          else if(state is LoadingState){
            return loadingWidget();
          }
          else if (state is LoadedState){
            return dataWidget(state.userDetail,state.recommendationsDetail,false);
          }
          else if (state is ErrorState){
            return errorWidget(state.message);
          }
          else if (state is ReLoadedState){
            init = false;
            return dataWidget(state.userDetail,state.recommendationsDetail,false);
          }
          else if (state is ReLoadingState){
            return dataWidget(state.userDetail,state.recommendationsDetail,true);
          }
          else{
            return Container();
          }

        },

      ),

    );
  }

  Widget loadingWidget(){

    return Center(
      child: CircularProgressIndicator(),
    );

  }

  Widget dataWidget(UserDetail userDetail,RecommendationsDetail recommendationsDetail,isReloading){

    return Container(

      child: SingleChildScrollView(

        controller: scrollController,

        child: Column(

          children: [

            Container(

                margin: EdgeInsets.symmetric(horizontal: 16.0),

                child: UserDetails(userDetail: userDetail)
            ),

            SizedBox(height: 16,),


            (userDetail.favorite_games.length > 0) ? Container(

                margin: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,

                child: Text(getTranslated(context, KeyStrings.favouriteGames),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),)
            ) : Container(),

            (userDetail.favorite_games.length > 0) ? Container(

                height: 140,

                child: ListView.builder(
                  itemCount: userDetail.favorite_games.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  itemBuilder: (context, index) {
                    return FavouriteGame(name:userDetail.favorite_games.elementAt(index));
                  },
                )

            ) : Container(),

            SizedBox(height: 16,),

            Container(

                margin: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,

                child: Text(getTranslated(context, KeyStrings.recommendedForYou),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),)
            ),

            SizedBox(height: 16,),

            RecommendationList(tournaments:  recommendationsDetail.tournaments),

            isReloading ? CircularProgressIndicator() : Container(),

          ],
        ),
      ),
    );

  }

  Widget errorWidget(String message){

    return Center(
      child: Text(message),
    );

  }

  Widget drawerData(UserDetail userDetail){

    return Container(

      padding: EdgeInsets.only(top: 32, bottom: 16),

      color: Colors.black87,

      child: UserAccountsDrawerHeader(

        decoration: BoxDecoration(

            color: Colors.transparent
        ),


        accountName: Text(userDetail.username, style: TextStyle(color: Colors.white),),

        accountEmail: Text(userDetail.overall_rating.toString() + " " + getTranslated(context, KeyStrings.eloRating)  , style: TextStyle(color: Colors.white),),

        currentAccountPicture:
        Container(

          alignment: Alignment.center,

          decoration: new BoxDecoration(
              border: Border.all(color: Colors.black54),
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(userDetail.avatarUrl),
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
