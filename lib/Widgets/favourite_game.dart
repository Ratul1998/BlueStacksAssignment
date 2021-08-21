import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavouriteGame extends StatelessWidget{

  String name;

  FavouriteGame({this.name});

  @override
  Widget build(BuildContext context) {

    return Container(
      
      margin: EdgeInsets.all(8),

      child: Column(

        children: [

          Container(

            width: 96,
            height: 96,

            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [const BoxShadow(

                color: Colors.black45,
                blurRadius: 5,
                spreadRadius: 0

              )]

            ),

          ),

          Container(

            margin: EdgeInsets.only(top: 8),

            child: Text(name,style: TextStyle(color: Colors.black,fontSize: 14),),

          )

        ],

      )

    );

  }



}