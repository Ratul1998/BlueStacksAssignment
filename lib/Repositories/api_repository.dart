import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bluestack_assignment/Config/ApiStatusKey.dart';
import 'package:bluestack_assignment/DataModels/RecommendationsDetail.dart';
import 'package:bluestack_assignment/DataModels/UserDetail.dart';
import 'package:http/http.dart' as http;

class ApiRepository{

  static const String userApi = "https://tournaments-uat-dot-game-tv-engg.appspot.com/profile/user_info";
  static const String api = "https://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/";


  Future<UserDetail> getUserDetail(String userId,String token) async {

    final queryParameters = {

      "profile_user_id": "",
      "user_id": "S5nua460TONzetIIfIgKkFFiQzv1",
      "token": "cf2005e4-f328-444f-a551-c47755d7af51",
      "lang": "en",
      "country": "IN",
      "client": "app"


    };

    String queryString = Uri(queryParameters: queryParameters).query;

    var requestURL = userApi + '?' + queryString;

    var response = await http.get(Uri.parse(requestURL), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });



    if(response.statusCode == ApiResponseCode.SUCCESS){

      UserDetail userDetail = UserDetail.factory(jsonDecode(response.body));

      userDetail.favorite_games.add("Clash of Clans#https://cdn.freelogovectors.net/wp-content/uploads/2019/01/clash_of_clans_logo.png#");
      userDetail.favorite_games.add("Rumble Stars#https://media.pocketgamer.com/artwork/na-nsfvfkb/rumble-stars-soccer-ios-screenshot-the-games-logo_jpg_640.webp#");
      userDetail.favorite_games.add("PUBG#https://seeklogo.com/images/P/pubg-mobile-logo-28E182F8A8-seeklogo.com.png#");
      userDetail.favorite_games.add("COD Mobile#https://vectrostudio.com/wp-content/uploads/2020/03/Download-Call-Of-Duty-Mobile-Logo-Vector.jpg#");
      userDetail.favorite_games.add("Free Fire#https://www.xtrafondos.com/wallpapers/free-fire-logo-3537.jpg#");
      userDetail.favorite_games.add("Asphalt 9#https://media.pocketgamer.biz/2021/2/109069/asphalt-9-legends-logo-r225x.jpg#");

      return userDetail;

    }
    else{

      throw Exception(response.statusCode);

    }

  }


  Future<RecommendationsDetail> getRecommendationDetails(int itemCount) async {

    var response = await http.get(Uri.parse(api + "tournaments_list_v2?limit=$itemCount&status=all"),  headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });

    if(response.statusCode == ApiResponseCode.SUCCESS){

      log(response.body);

      RecommendationsDetail recommendationsDetail = RecommendationsDetail.fromJson(jsonDecode(response.body));

      return recommendationsDetail;

    }
    else{

      throw Exception(response.statusCode);

    }

  }


  Future<RecommendationsDetail> getNextRecommendationDetails(int itemCount, String cursor) async {

    print("Cursor  :  " + cursor);

    var response = await http.get(Uri.parse(api + "tournaments_list_v2?limit=$itemCount&status=all&cursor=$cursor"),  headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });

    if(response.statusCode == ApiResponseCode.SUCCESS){

      RecommendationsDetail recommendationsDetail = RecommendationsDetail.fromJson(jsonDecode(response.body));

      return recommendationsDetail;

    }
    else{

      throw Exception(response.statusCode);

    }

  }



}