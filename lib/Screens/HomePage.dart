import 'package:bluestack_assignment/Bloc/home_page_bloc/tournament_bloc/tournament_bloc.dart';
import 'package:bluestack_assignment/Bloc/home_page_bloc/tournament_bloc/tournament_event.dart';
import 'package:bluestack_assignment/Bloc/home_page_bloc/tournament_bloc/tournament_state.dart';
import 'package:bluestack_assignment/Bloc/home_page_bloc/user_detail_bloc/user_detail_bloc.dart';
import 'package:bluestack_assignment/Bloc/home_page_bloc/user_detail_bloc/user_detail_event.dart';
import 'package:bluestack_assignment/Bloc/home_page_bloc/user_detail_bloc/user_detail_state.dart';
import 'package:bluestack_assignment/Config/KeyStrings.dart';
import 'package:bluestack_assignment/DataModels/RecommendationsDetail.dart';
import 'package:bluestack_assignment/DataModels/UserDetail.dart';
import 'package:bluestack_assignment/Widgets/MyAppBar.dart';
import 'package:bluestack_assignment/Widgets/NavigationDrawer.dart';
import 'package:bluestack_assignment/Widgets/favourite_game.dart';
import 'package:bluestack_assignment/Widgets/loading_widget.dart';
import 'package:bluestack_assignment/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Widgets/RecommendationList.dart';
import '../Widgets/UserDetails.dart';

class HomePage extends StatefulWidget {

  String userID;
  String token;


  HomePage({this.userID,this.token});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage>{

  HomePageBloc homePageBloc;

  TournamentBloc tournamentBloc;

  bool init = false;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {

    super.initState();

    homePageBloc = BlocProvider.of<HomePageBloc>(context);

    tournamentBloc = BlocProvider.of<TournamentBloc>(context);

    homePageBloc.add(FetchingUserData());

    tournamentBloc.add(FetchTournamentData());

    scrollController.addListener(() async {

      if(scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {

        if(!init){

          tournamentBloc.add(FetchTournamentData());
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

      drawer: BlocBuilder<HomePageBloc,UserDetailState>(

        builder: (context,state){

          if(state is UninitializedState){
            return NavigationDrawer(homePage: true,);
          }
          else if(state is UserDetailLoadingState){
            return NavigationDrawer(homePage: true,);
          }
          else if (state is UserDetailLoadedState){
            return NavigationDrawer(username: state.userDetail.username,avatarUrl: state.userDetail.avatarUrl,overallRating: state.userDetail.overall_rating,homePage: true,);
          }
          else if (state is UserDetailErrorState){
            return Container();
          }
          else{
            return Container();
          }

        },

      ),

      appBar: MyAppBar(scaffoldKey: _scaffoldKey,appBarTitle: KeyStrings.appBarTitle,),

      body: SingleChildScrollView(

        controller: scrollController,

        child: Column(

          children: [

            BlocBuilder<HomePageBloc,UserDetailState>(

              builder: (context,state){

                if(state is UninitializedState){
                  return LoadingWidget();
                }
                else if(state is UserDetailLoadingState){
                  return LoadingWidget();
                }
                else if (state is UserDetailLoadedState){
                  return userDataWidget(state.userDetail);
                }
                else if (state is UserDetailErrorState){
                  return errorWidget(state.message);
                }
                else{
                  return Container();
                }

              },

            ),

            BlocBuilder<TournamentBloc,TournamentState>(

              builder: (context,state){

                if(state is UninitializedState){
                  return LoadingWidget();
                }
                else if(state is TournamentLoadingState){

                  if(state.recommendationsDetail == null)
                    return LoadingWidget();
                  else
                    return tournamentDataWidget(state.recommendationsDetail,true);


                }
                else if (state is TournamentLoadedState){
                  return tournamentDataWidget(state.recommendationsDetail,false);
                }
                else if (state is TournamentErrorState){
                  return errorWidget(state.message);
                }
                else{
                  return Container();
                }

              },

            ),


          ],

        ),

      )
    );
  }

  Widget userDataWidget(UserDetail userDetail){

    return Container(

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

        ],
      ),
    );

  }

  Widget tournamentDataWidget(RecommendationsDetail recommendationsDetail,isReloading){

    return Column(

      children: [

        Container(

            margin: EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,

            child: Text(getTranslated(context, KeyStrings.recommendedForYou),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),)
        ),

        SizedBox(height: 16,),

        RecommendationList(tournaments:  recommendationsDetail.tournaments),

        isReloading ? CircularProgressIndicator() : Container(),

      ],

    );

  }

  Widget errorWidget(String message){

    return Center(
      child: Text(message),
    );

  }


}
