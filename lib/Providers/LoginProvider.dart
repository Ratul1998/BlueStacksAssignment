import 'package:bluestack_assignment/Config/SharedPreferenceKey.dart';
import 'package:bluestack_assignment/Config/KeyStrings.dart';
import 'package:bluestack_assignment/Screens/HomePage.dart';
import 'package:bluestack_assignment/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier{

  Map<String,String> loginCredentials = {

    '9898989898':'password',
    '9876543210':'password',
    'ratul':'edward1998',

  };

  String userName = "";
  String password = "";

  String userNameErrorText;
  String passwordErrorText;


  BuildContext context;

  bool hidePassword = true;


  // initialize function
  void init(BuildContext context) {

    this.context = context;

  }

  // to show corresponding message on changing userName
  void onUserNameChange (String text) {

    userName = text;

    if(userName.length >=3 && userName.length<=10)
      userNameErrorText = null;

    notifyListeners();

  }

  // to show corresponding message on changing password
  void onPasswordChange (String text) {

    password = text;

    if(password.length >=3 && password.length<=10)
      passwordErrorText = null;

    notifyListeners();

  }

  bool validateUserName () {

    if(userName.length < 3 || userName.length > 10) {
       userNameErrorText = getTranslated(context, KeyStrings.userNameErrorText);
       return false;
    }
    else{
      userNameErrorText = null;
      return true;
    }


  }

  bool validatePassword () {

    if(password.length < 3 || password.length > 10) {
       passwordErrorText = getTranslated(context, KeyStrings.passwordErrorText);
       return false;
    }
    else{
      passwordErrorText = null;
      return true;
    }
  }

  void onSubmit() async {

    if(validateUserName() && validatePassword()) {

      if(!loginCredentials.containsKey(userName)){

        userNameErrorText = getTranslated(context, KeyStrings.userNotFound);
        passwordErrorText = null;

      }
      else if(loginCredentials.containsKey(userName) && loginCredentials[userName] == password){

        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString(SharedPreferenceKey.userName, userName);
        sharedPreferences.setString(SharedPreferenceKey.password, password);
        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>HomePage(userID: userName,)));

      }
      else{

        userNameErrorText = null;
        passwordErrorText = getTranslated(context, KeyStrings.invalidPassword);

      }
    }

    notifyListeners();

  }

  void onPasswordSeen() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

}