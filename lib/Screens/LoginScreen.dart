import 'package:bluestack_assignment/Config/KeyStrings.dart';
import 'package:bluestack_assignment/Providers/LoginProvider.dart';
import 'package:bluestack_assignment/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {

  bool init = false;

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      lazy: false,
      create: (context)=>LoginProvider(),

      child: Consumer<LoginProvider>(

        builder: (BuildContext context, LoginProvider value, Widget child) {

          if(!init) {
            Provider.of<LoginProvider>(context, listen: false).init(context);
            init = true;
          }

          return Scaffold(

            backgroundColor: Colors.white,

            body: Container(

              color: Colors.black87,

              child: Stack(

                children: [

                  Container(

                    alignment: Alignment.bottomCenter,

                    child: Image.asset(
                      'assets/images/controller.png',
                      height: 180,
                      width: 180,
                      color: Colors.white.withOpacity(0.4),

                    ),
                  ),

                  Center(

                    child: SingleChildScrollView(

                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [

                          Image.asset(
                            'assets/images/game_tv_logo.png',
                            height: 180,
                            width: 180,
                            color: Colors.white,
                          ),

                          Container(

                            child: Text(

                              getTranslated(context, KeyStrings.mobileEsportsLive).toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 16),

                            ),

                          ),

                          SizedBox(height: 64,),

                          Container(

                            margin: EdgeInsets.symmetric(horizontal: 32,vertical: 32),

                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(12),

                              color: Colors.white,

                              boxShadow: [BoxShadow(

                                blurRadius: 6,
                                color: Colors.white,

                              )]

                            ),

                            child: Column(

                              children: [

                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),

                                  margin: EdgeInsets.only(left: 12, right: 12, top: 24),

                                  child: TextFormField(

                                      onChanged: value.onUserNameChange,

                                      decoration: InputDecoration(

                                        labelText: getTranslated(context, KeyStrings.userName),

                                        errorText: value.userNameErrorText,

                                        prefixIcon: Icon(Icons.person),

                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),

                                      )),
                                ),

                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                  margin: EdgeInsets.only(left: 12, right: 12, top: 32),
                                  child: TextFormField(

                                      onChanged: value.onPasswordChange,

                                      obscureText: value.hidePassword,

                                      decoration: InputDecoration(

                                        labelText: getTranslated(context, KeyStrings.password),

                                        errorText: value.passwordErrorText,

                                        prefixIcon: Icon(Icons.lock),

                                        suffixIcon: IconButton(

                                          onPressed: value.onPasswordSeen,

                                          icon: Icon(Icons.remove_red_eye, size: 20,),

                                        ),

                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                                      )),
                                ),

                                SizedBox(height: 24,),

                                ElevatedButton(

                                  child: Padding(

                                    padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 12.0),

                                    child: Text(
                                        getTranslated(context, KeyStrings.submit),
                                        style: TextStyle(fontSize: 14)
                                    ),
                                  ),

                                  style: ButtonStyle(

                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(4)),
                                              side: BorderSide(color: Colors.black)
                                          )
                                      )
                                  ),

                                  onPressed: value.onSubmit,
                                ),

                                SizedBox(height: 24,),

                              ],

                            ),

                          ),

                          SizedBox(height: 16,),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ) ,
          );


        },

      ) ,
    );
  }
}
