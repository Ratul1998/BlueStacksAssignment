import 'package:bluestack_assignment/Bloc/notification_bloc/notification_bloc.dart';
import 'package:bluestack_assignment/Repositories/firebase_repository.dart';
import 'package:bluestack_assignment/Screens/LanguageScreen.dart';
import 'package:bluestack_assignment/Screens/notification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/home_page_bloc/home_page_bloc.dart';
import 'Repositories/api_repository.dart';
import 'Repositories/auth_repository.dart';
import 'Screens/HomePage.dart';
import 'Screens/LoginScreen.dart';

class Routes {

  static const String homeRoute = '/homepage';
  static const String login = '/login';
  static const String changeLanguage = '/changeLanguage';
  static const String notifications = '/notification';

  static Route<dynamic> generateRoute(RouteSettings settings) {

    var data = settings.arguments as Map;

    print(data);

    switch (settings.name) {
      case homeRoute:

        String userID = data['user_id'];
        String token = data['token'];

        return MaterialPageRoute(builder: (_) => RepositoryProvider(

            create:(context) => ApiRepository(),

            child: BlocProvider(

              create: (context) => HomePageBloc(apiRepository: context.read<ApiRepository>(),userId: userID,token: token),

              child: HomePage(userID: userID,token: token,),

            )
        ));

      case login:
        return MaterialPageRoute(builder: (_) => RepositoryProvider(create:(context) => AuthRepository(), child: LoginScreen()));

      case changeLanguage:
        return MaterialPageRoute(builder: (_) => LanguageScreen());

      case notifications:
        return MaterialPageRoute(builder: (_) => RepositoryProvider(

            create:(context) => FirebaseRepository(),

            child: BlocProvider(

              create: (context) => NotificationBloc(firebaseRepository: context.read<FirebaseRepository>()),

              child: Notifications(),

            )
        ));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }


}