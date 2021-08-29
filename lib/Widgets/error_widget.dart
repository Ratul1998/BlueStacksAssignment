import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget{

  String message;

  MyErrorWidget({this.message});

  @override
  Widget build(BuildContext context) {

    return Container(

      height: 420,

      child: Center(

        child: Container(

          alignment: Alignment.center,

          width: MediaQuery.of(context).size.width,

          padding: EdgeInsets.all(16),

          child: Text(message,style: TextStyle(color: Colors.redAccent,fontSize: 16,), maxLines: 3 , overflow: TextOverflow.ellipsis,),

        ),

      ),

    );

  }



}