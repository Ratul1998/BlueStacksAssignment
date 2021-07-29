import 'Tournament.dart';

class RecommendationsDetail {

  RecommendationsDetail({this.cursor,this.tournaments});

  String cursor;
  List<Tournament> tournaments;

  factory RecommendationsDetail.fromJson(Map<String, dynamic> json) {

    if (json == null) return null;

    RecommendationsDetail recommendationsDetail = RecommendationsDetail(
      cursor: json['data']['cursor'] ,
      tournaments: List<Tournament>.from(
          json['data']['tournaments'].map((x) => Tournament.fromJson(x))),
    );

    return recommendationsDetail;
  }

}

