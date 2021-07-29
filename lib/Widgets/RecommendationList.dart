import 'package:bluestack_assignment/DataModels/Tournament.dart';
import 'package:bluestack_assignment/Widgets/ListItem.dart';
import 'package:flutter/material.dart';

class RecommendationList extends StatelessWidget {


   List<Tournament> tournaments;


   RecommendationList({this.tournaments});


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tournaments.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {

        return ListItem(tournaments: tournaments.elementAt(index),);
      },

    );
  }
}
