import 'package:bluestack_assignment/Bloc/home_page_bloc/api_repository.dart';
import 'package:bluestack_assignment/Bloc/login_bloc/auth_repository.dart';
import 'package:bluestack_assignment/Screens/HomePage.dart';
import 'package:bluestack_assignment/Screens/LoginScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/home_page_bloc/home_page_bloc.dart';
import 'Config/SharedPreferenceKey.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localization/demo_localization.dart';
import 'localization/language_constants.dart';



Future<void> main () async {

  WidgetsFlutterBinding.ensureInitialized();

  //Getting SharedPreferences to check if the user has already logged in or not
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  if (sharedPreferences.getString(SharedPreferenceKey.userName) == null) {

    runApp(MyApp(isSignedIn: false,));

  }else{

    runApp(MyApp(isSignedIn: true,token:sharedPreferences.getString(SharedPreferenceKey.password),userID:sharedPreferences.getString(SharedPreferenceKey.userName)));

  }


}


class MyApp extends StatefulWidget  {

  bool isSignedIn = false;

  String userID;
  String token;

  MyApp({this.isSignedIn,this.userID,this.token});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();

    getLocale().then((locale) {
      setState(() {
        this._locale = locale;

      });
    });

  }


  @override
  Widget build(BuildContext context) {


    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      locale: _locale,
      supportedLocales: [
        Locale("en", "US"),
        Locale("ja", "JP")
      ],
      localizationsDelegates: [
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },

      routes: {

        '/login': (context) => RepositoryProvider(create:(context) => AuthRepository(), child: LoginScreen()),
        '/homepage' : (context) => RepositoryProvider(create:(context) => ApiRepository(), child: HomePage(userID: widget.userID,token: widget.token,))

      },

      home:  widget.isSignedIn ?

      RepositoryProvider(

          create:(context) => ApiRepository(),

          child: BlocProvider(

            create: (context) => HomePageBloc(apiRepository: context.read<ApiRepository>(),userId: widget.userID,token: widget.token),

            child: HomePage(userID: widget.userID,token: widget.token,),

          )
      ) :
      RepositoryProvider(create:(context) => AuthRepository(), child: LoginScreen()),
    );
  }


}


