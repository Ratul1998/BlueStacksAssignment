import 'package:bluestack_assignment/Bloc/login_bloc/form_submission_status.dart';

class LoginState {

  final String username;
  final String password;
  final FormSubmissionStatus formStatus;

  final bool isPasswordVisible;

  bool get isValidUserName => username.length >= 3;
  bool get isValidPassword => password.length >= 3 && password.length <=10;

  LoginState({this.username = '',this.password = '',this.formStatus = const InitialFormStatus(), this.isPasswordVisible = false});

  LoginState copyWith({String username, String password, FormSubmissionStatus formStatus,bool isPasswordVisible}){
    return LoginState(username: username??this.username,password: password??this.password,formStatus: formStatus??this.formStatus,isPasswordVisible: isPasswordVisible??this.isPasswordVisible);
  }

}