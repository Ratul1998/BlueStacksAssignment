import 'dart:convert';

import 'package:bluestack_assignment/Config/KeyStrings.dart';
import 'package:bluestack_assignment/DataModels/Tournament.dart';
import 'package:bluestack_assignment/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TournamentScreen extends StatefulWidget{

  Tournament tournament;

  TournamentScreen({this.tournament});


  @override
  TournamentState createState() => TournamentState();

}

class TournamentState extends State<TournamentScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: NestedScrollView(

        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {

          return <Widget>[

            SliverAppBar(

              expandedHeight: 200.0,

              floating: false,

              pinned: true,

              flexibleSpace: FlexibleSpaceBar(

                  centerTitle: true,

                  collapseMode: CollapseMode.pin,

                  titlePadding: EdgeInsets.all(0),

                  title: Container(

                    color: Colors.black54,

                    height: 56,

                    width: double.maxFinite,

                    alignment: Alignment.center,

                    padding: EdgeInsets.all(8),

                    child: Text(widget.tournament.name,

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          color: Colors.white,

                          fontSize: 16.0,

                        )),
                  ),
                  background: Image.network(

                    widget.tournament.coverUrl,

                    fit: BoxFit.cover,

                  )),
            ),

            SliverPersistentHeader(

              delegate: _SliverAppBarDelegate(

                gameName: widget.tournament.gameName,

                imageURL: widget.tournament.game_icon_url,

              ),

              pinned: true,
            ),

          ];
        },
        body: SingleChildScrollView(

          child: Column(

            children: [

              Row(
                children: [

                  Container(

                      margin: EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
                      alignment: Alignment.centerLeft,

                      child: Text(getTranslated(context, KeyStrings.tournamentDetails),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),)
                  ),

                  Expanded(child: Divider(height: 1,color: Colors.black54,)),
                ],
              ),

              Container(

                padding: EdgeInsets.all(16),

                child: Column(

                    children: split(widget.tournament.details).map((e) {

                      if(e.isNotEmpty){

                        return Row(

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            Container(margin:EdgeInsets.only(top: 20),child: Icon(Icons.circle,size: 14,color: Colors.black87,)),

                            Expanded(

                              child: Container(

                                margin: EdgeInsets.only(left: 16,top: 16),

                                child: Text(e.substring(3),style: TextStyle(color: Colors.black54,fontSize: 20),),),
                            )

                          ],

                        );

                      }
                      else{
                        return Container();
                      }

                    }).toList()

                ),
              ),

              Row(

                children: [

                  Container(

                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,

                      child: Text(getTranslated(context, KeyStrings.tournamentRules),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),)
                  ),

                  Expanded(child: Divider(height: 1,color: Colors.black54,)),

                ],
              ),

              Container(

                padding: EdgeInsets.all(16),

                child: Column(

                    children: split(widget.tournament.rules).map((e) {

                      if(e.isNotEmpty){

                        return Row(

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            Container(margin:EdgeInsets.only(top: 20),child: Icon(Icons.circle,size: 14,color: Colors.black87,)),

                            Expanded(

                              child: Container(

                                margin: EdgeInsets.only(left: 16,top: 16),

                                child: Text(e.substring(3),style: TextStyle(color: Colors.black54,fontSize: 20),),),
                            )

                          ],

                        );

                      }
                      else{
                        return Container();
                      }

                    }).toList()

                ),
              ),

            ],
          ),
        ),
      ),
    );

  }

  List<String> split(String data){

    LineSplitter lineSplitter = new LineSplitter();

    List<String> lines = lineSplitter.convert(data);

    return lines;

  }

}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {

  String imageURL,gameName;

  _SliverAppBarDelegate({this.imageURL,this.gameName});

  @override
  double get minExtent => 56;
  @override
  double get maxExtent => 56;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(

      height: 56,

      color: Colors.blueAccent,

      alignment: Alignment.center,

      child: Row(

        mainAxisSize: MainAxisSize.min,

        children: [

          Container(

            width: 40,
            height: 40,
            

            decoration: BoxDecoration(

              image: DecorationImage(image: NetworkImage(imageURL)),
              
              borderRadius: BorderRadius.circular(8),

              boxShadow: [const BoxShadow(

                color: Colors.black26,

                blurRadius: 6,


              )]

            ),

          ),

          Container(

            margin: EdgeInsets.only(left: 8),

            child: Text(gameName,

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500
                )),

          )

        ],

      ),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}