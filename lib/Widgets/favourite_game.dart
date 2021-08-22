import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavouriteGame extends StatelessWidget{

  String name;

  FavouriteGame({this.name});
  
  String getName(String s){
    return s.split('#').elementAt(0);
  }

  String getImage(String s){
    return s.split('#').elementAt(1);
  }

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


              image: DecorationImage(

                image: NetworkImage(getImage(name)),

                fit: BoxFit.fill,

              ),
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [const BoxShadow(

                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 0

              )]

            ),

          ),

          Container(

            margin: EdgeInsets.only(top: 8),

            alignment: Alignment.center,

            width: 96,

            child: Text(getName(name),overflow:TextOverflow.ellipsis ,style: TextStyle(color: Colors.black,fontSize: 14),),

          )

        ],

      )

    );

  }



}