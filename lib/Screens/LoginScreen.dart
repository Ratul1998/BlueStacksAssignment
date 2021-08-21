import 'package:bluestack_assignment/Repositories/api_repository.dart';
import 'package:bluestack_assignment/Bloc/home_page_bloc/home_page_bloc.dart';
import 'package:bluestack_assignment/Repositories/auth_repository.dart';
import 'package:bluestack_assignment/Bloc/login_bloc/form_submission_status.dart';
import 'package:bluestack_assignment/Bloc/login_bloc/login_bloc.dart';
import 'package:bluestack_assignment/Bloc/login_bloc/login_event.dart';
import 'package:bluestack_assignment/Bloc/login_bloc/login_state.dart';
import 'package:bluestack_assignment/Config/KeyStrings.dart';
import 'package:bluestack_assignment/localization/language_constants.dart';
import 'package:bluestack_assignment/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';

class LoginScreen extends StatelessWidget {

  bool init = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: BlocProvider(

        create: (context) => LoginBloc(authRepository: context.read<AuthRepository>()),

        child: Container(

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

                        child: BlocListener<LoginBloc,LoginState>(

                          listener: (context,state){

                            final formStatus = state.formStatus;

                            if(formStatus is SubmissionFailed){
                              _showSnackBar(context, formStatus.exception.toString());
                            }
                            else if(formStatus is SubmittingSuccess){

                              Navigator.pop(context);

                              var args = {

                                "user_id":state.username,
                                "token":state.password,

                              };

                              Navigator.pushNamed(context, Routes.homeRoute,arguments: args);
                            }

                          },

                          child: Form(

                            key: _formKey,

                            child: Column(

                              children: [

                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),

                                  margin: EdgeInsets.only(left: 12, right: 12, top: 24),

                                  child: BlocBuilder<LoginBloc,LoginState>(

                                    builder: (BuildContext context, state) {

                                      return TextFormField(

                                          onChanged: (value)=> context.read<LoginBloc>().add(UsernameChanged(username: value)),

                                          validator: (value) => state.isValidUserName ? null : getTranslated(context, KeyStrings.userNameErrorText),

                                          decoration: InputDecoration(

                                            labelText: getTranslated(context, KeyStrings.userName),

                                            prefixIcon: Icon(Icons.person),

                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),

                                          ));

                                    },

                                  ),
                                ),

                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                  margin: EdgeInsets.only(left: 12, right: 12, top: 32),
                                  child: BlocBuilder<LoginBloc,LoginState>(

                                    builder: (BuildContext context,state){

                                      return TextFormField(

                                          onChanged: (value) => context.read<LoginBloc>().add(PasswordChanged(password: value)),

                                          validator: (value) => state.isValidPassword ? null : getTranslated(context, KeyStrings.passwordErrorText),

                                          obscureText: !state.isPasswordVisible,

                                          decoration: InputDecoration(

                                            labelText: getTranslated(context, KeyStrings.password),


                                            prefixIcon: Icon(Icons.lock),

                                            suffixIcon: IconButton(

                                              onPressed: () => context.read<LoginBloc>().add(PasswordVisibilityChanged()),

                                              icon: Icon(Icons.remove_red_eye, size: 20,),

                                            ),

                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                                          ));

                                    },
                                  ),
                                ),

                                SizedBox(height: 24,),

                                BlocBuilder<LoginBloc,LoginState>(

                                  builder: (BuildContext context, state) {

                                    return state.formStatus is FormSubmitting ? CircularProgressIndicator() :ElevatedButton(

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

                                      onPressed: (){

                                        if(_formKey.currentState.validate()){
                                          FocusScope.of(context).unfocus();
                                          context.read<LoginBloc>().add(LoginSubmitted());
                                        }


                                      },
                                    );

                                  },
                                ),

                                SizedBox(height: 24,),

                              ],

                            ),
                          ),
                        ),

                      ),

                      SizedBox(height: 16,),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ) ,
    );
  }

  void _showSnackBar(BuildContext context,String message){

    final snackBar = SnackBar(backgroundColor:Colors.white,content: Text(message,style: TextStyle(color: Colors.black87),));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
}
