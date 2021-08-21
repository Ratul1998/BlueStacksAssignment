import 'package:bluestack_assignment/Config/SharedPreferenceKey.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {

  Map<String,String> loginCredentials = {

    '9898989898':'password',
    '9876543210':'password',
    'ratul':'edward1998',

  };


  Future<void> login(String userName,String password) async {

    print("Username : " + userName + "  Password : " + password);

    if(!loginCredentials.containsKey(userName)){

      throw Exception('User does not exists');

    }
    else if(loginCredentials.containsKey(userName) && loginCredentials[userName] == password){

      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString(SharedPreferenceKey.userName, userName);
      sharedPreferences.setString(SharedPreferenceKey.password, password);


    }
    else{

      throw Exception('Incorrect Password');

    }


  }

}