import 'package:bluestack_assignment/Bloc/home_page_bloc/user_detail_bloc/user_detail_bloc.dart';
import 'package:bluestack_assignment/Bloc/home_page_bloc/user_detail_bloc/user_detail_event.dart';
import 'package:bluestack_assignment/Config/ColorPalettes.dart';
import 'package:bluestack_assignment/Config/KeyStrings.dart';
import 'package:bluestack_assignment/DataModels/UserDetail.dart';
import 'package:bluestack_assignment/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetails extends StatelessWidget {

 UserDetail userDetail;

 bool isInEditMode;

 String editedUsername;

 final _formKey = GlobalKey<FormState>();

 UserDetails({ this.userDetail,this.isInEditMode});

 double calculatePercentageWin(int totalTournamentPlayed, int totalTournamentWon) {

   double winPercent = (totalTournamentWon/totalTournamentPlayed)*100;
   double val =  double.parse((winPercent).toStringAsFixed(1));
   return val;


 }

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: EdgeInsets.symmetric(vertical: 16.0),
      width: double.maxFinite,

      child: Column(

        children: [

          Row(

            children: [

              Container(

                width: 80.0,

                height: 80.0,

                alignment: Alignment.center,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black54),
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image:  NetworkImage(userDetail.avatarUrl),
                    )
                ),

                child : Container() ,

              ),

              SizedBox(width: 16,),

              Expanded(

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                  (isInEditMode) ? Container(

                    height: 80,

                    child: Form(

                      key: _formKey,

                      child: TextFormField(



                            onChanged: (value)=> editedUsername = value,

                            initialValue: userDetail.username,

                            validator: (value) => (value.length >=3) ? null : getTranslated(context, KeyStrings.userNameErrorText),

                            decoration: InputDecoration(

                              labelText: getTranslated(context, KeyStrings.userName),

                              prefixIcon: Icon(Icons.person),

                              suffixIcon: IconButton(

                                icon: Icon(Icons.check),onPressed: () {

                                  if(_formKey.currentState.validate())
                                    BlocProvider.of<HomePageBloc>(context).add(ChangeUserName(userName: (editedUsername!=null) ? editedUsername : userDetail.username));

                                } ,
                              ),

                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),

                            )),
                    ),


                  ) : Container(

                          child: Row(

                            children: [
                              Text(userDetail.username, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),),

                              IconButton(

                                  padding: EdgeInsets.symmetric(horizontal: 8),

                                  icon: Icon(Icons.edit,size: 20,color: Colors.blueAccent,),

                                  onPressed: () => BlocProvider.of<HomePageBloc>(context).add(UserTextFieldVisible(visible: true)),

                              ),

                            ],
                          ),
                        ),

                    SizedBox(height: 16.0,),

                    Container(

                      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.all(Radius.circular(48.0)),
                        border: Border.all(color: Colors.blue)



                      ),
                      child: Row(

                        mainAxisSize: MainAxisSize.min,

                        children: [

                          Container(

                            child: Text(userDetail.overall_rating.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),),
                          ),

                          SizedBox(width: 16,),

                          Container(

                            child: Text(getTranslated(context, KeyStrings.eloRating), style: TextStyle(color: Colors.grey),),
                          ),

                        ],
                      ),
                    ),


                  ],
                ),
              ),

            ],
          ),

          SizedBox(height: 24,),

          Row(

            children: [

              Expanded(
                flex: 1,
                child: Container(

                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16.0),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), bottomLeft: Radius.circular(16.0)),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          ColorPalettes.mustard,
                          ColorPalettes.mustardLight,
                        ],
                      )
                  ),
                  child: Column(

                    children: [

                      Text(userDetail.tournaments_played.toString(), style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),),

                      SizedBox(height: 4,),

                      Text(getTranslated(context, KeyStrings.tournamentsPlayed), textAlign:TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.white),)
                    ],
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: Container(

                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16.0),

                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          ColorPalettes.darkBlue,
                          ColorPalettes.purple,
                        ],
                      )
                  ),

                  child: Column(

                    children: [

                      Text(userDetail.tournaments_won.toString(), style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),),

                      SizedBox(height: 4,),

                      Text(getTranslated(context, KeyStrings.tournamentsWon), textAlign:TextAlign.center, style: TextStyle( fontSize:12, color: Colors.white),)
                    ],
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: Container(

                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16.0),

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(16.0), bottomRight: Radius.circular(16.0)),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          ColorPalettes.redLight,
                          ColorPalettes.orangeLight,
                        ],
                      )
                  ),
                  child: Column(

                    children: [

                      Text((calculatePercentageWin(userDetail.tournaments_played, userDetail.tournaments_won).toString() + "%"), style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),),

                      SizedBox(height: 4,),

                      Text(getTranslated(context, KeyStrings.winningPercentage), textAlign:TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.white),)
                    ],
                  ),
                ),
              ),
            ],
          )

        ],
      ),


    );
  }
}
