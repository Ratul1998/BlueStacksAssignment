import 'dart:io';

import 'package:http/http.dart' as http;

class ApiConfig{

  static const String userApi = "https://ratul1998.herokuapp.com/api/user_detail/";
  static const String api = "https://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/";


  //for fetching user-detail
  static Future<http.Response> getUserDetail(String userId) async {

    try {
      return await http.get(Uri.parse(userApi + userId),  headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      });
    } catch (exception, stackTrace) {
      return exception;
    }
  }

  //for fetching first 10 recommended details data
  static Future<http.Response> getRecommendationDetails(int itemCount) async {

    try {
      var response = await http.get(Uri.parse(api + "tournaments_list_v2?limit=$itemCount&status=all"),  headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      return response;
    } catch (exception) {
      return exception;
    }
  }

  //for fetching next 10 recommended details data with cursor input param
  static Future<http.Response> getNextRecommendationDetails(int itemCount, String cursor) async {

    try {

      var response = await http.get(Uri.parse(api + "tournaments_list_v2?limit=$itemCount&status=all&cursor=$cursor"),  headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      return response;

    } catch (exception) {

      return exception;
    }
  }



}