import 'package:bluestack_assignment/DataModels/Tournament.dart';
import 'package:bluestack_assignment/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ListItem extends StatelessWidget {


  Tournament tournaments;
  ListItem({this.tournaments});

  @override
  Widget build(BuildContext context) {

    return Container(

      height: 240,
      padding: EdgeInsets.only(bottom: 16.0),
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0))
      ),



      child: InkWell(

        onTap: (){

          var args ={

            "name":tournaments.name,
            "cover_url":tournaments.coverUrl,
            "game_name":tournaments.gameName,
            "game_icon_url":tournaments.game_icon_url,
            "details":tournaments.details,
            "rules":tournaments.rules,

          };

          Navigator.pushNamed(context, Routes.tournament,arguments: args);

        },

        child: Card(
          elevation: 4.0,

          shadowColor: Theme.of(context).shadowColor,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),

          child: Container(

            decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              image: new DecorationImage(
                  fit: BoxFit.cover,
                  image:  NetworkImage(tournaments.coverUrl)
              ),

            ),


            child: Stack(

              children: [

                Positioned(

                  bottom: 0,
                  left: 0,
                  right: 0,

                  child: Container(

                    height: 85,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0))
                    ),

                    child: Row(

                      children: [

                        Expanded(
                          child: Column(

                            children: [

                              SizedBox(height: 16.0,),

                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(tournaments.name, overflow: TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.headline1,)
                              ),

                              SizedBox(height: 8.0,),

                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(tournaments.gameName,overflow: TextOverflow.ellipsis, maxLines: 1, style:Theme.of(context).textTheme.subtitle1,)
                              ),

                              SizedBox(height: 16.0,),
                            ],
                          ),
                        ),

                        Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color, size: 20,)

                      ],
                    )

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    
  }
}
