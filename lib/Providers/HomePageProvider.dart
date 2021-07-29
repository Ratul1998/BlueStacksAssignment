
import 'dart:convert';
import 'package:bluestack_assignment/Config/ApiStatusKey.dart';
import 'package:bluestack_assignment/Config/SharedPreferenceKey.dart';
import 'package:bluestack_assignment/DataModels/RecommendationsDetail.dart';
import 'package:bluestack_assignment/DataModels/UserDetail.dart';
import 'package:bluestack_assignment/Screens/LoginScreen.dart';
import 'package:bluestack_assignment/Services/ApiConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageProvider with ChangeNotifier {


  // Contains Detail of Users
  UserDetail userDetail;

  // Store recommendation detail
  RecommendationsDetail recommendationsDetail;

  BuildContext context;

  bool isDataLoaded = false;

  bool isListUpdating = false;


  // Calculate the win percentage of user
  double winPercent = 0;

  ScrollController scrollController = ScrollController();


  // Initialize homepage
  void init (BuildContext context,String userID) async {

    this.context = context;

    final userResponse = await ApiConfig.getUserDetail(userID);

    if(userResponse.statusCode == ApiResponseCode.SUCCESS) {
      var map = jsonDecode(userResponse.body);
      userDetail = UserDetail.factory(map);
    }

    final recommendationResponse =  await ApiConfig.getRecommendationDetails(10);

    if(recommendationResponse.statusCode == ApiResponseCode.SUCCESS) {

      Map<String, dynamic> map = jsonDecode(recommendationResponse.body);
      recommendationsDetail = RecommendationsDetail.fromJson(map);

    }

    isDataLoaded = true;

    notifyListeners();

    //Attaching listener to scroll view
    scrollController.addListener(() async {

      if(scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {

        isListUpdating = true;
        notifyListeners();

        await getNextItems(10, recommendationsDetail.cursor);

        isListUpdating = false;
        notifyListeners();

      }

    });



  }


  //Fetch next 10 items and add to list
  Future<void> getNextItems (int itemCount, String cursor) async {

    try {

      final response =  await ApiConfig.getNextRecommendationDetails(itemCount, cursor);

      if(response.statusCode == ApiResponseCode.SUCCESS) {

        Map<String, dynamic> map = jsonDecode(response.body);
        RecommendationsDetail tempRecommendationsDetail = RecommendationsDetail.fromJson(map);
        recommendationsDetail.cursor = tempRecommendationsDetail.cursor;
        recommendationsDetail.tournaments.addAll(tempRecommendationsDetail.tournaments);

      }

    } catch (exception) {

      print(exception.toString());
    }

  }


  // calculating user percentage rate
  double calculatePercentageWin(int totalTournamentPlayed, int totalTournamentWon) {

      winPercent = (totalTournamentWon/totalTournamentPlayed)*100;
      double val =  double.parse((winPercent).toStringAsFixed(1));
      return val;


  }

  // clearing sharedPreference data on logout
  void onLogOut() async {

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(SharedPreferenceKey.userName);
    sharedPreferences.remove(SharedPreferenceKey.password);

    Navigator.pop(context);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) =>LoginScreen()));

  }

  // disposing controllers
   @override
  void dispose() {
   scrollController.dispose();
   super.dispose();
  }
}