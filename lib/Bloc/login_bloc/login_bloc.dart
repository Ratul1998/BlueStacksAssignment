import 'package:bluestack_assignment/Repositories/auth_repository.dart';
import 'package:bluestack_assignment/Bloc/login_bloc/form_submission_status.dart';
import 'package:bluestack_assignment/Bloc/login_bloc/login_event.dart';
import 'package:bluestack_assignment/Bloc/login_bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState> {

  final AuthRepository authRepository;

  LoginBloc({this.authRepository}):super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {

    if(event is UsernameChanged){

      yield state.copyWith(username: event.username);

    }

    else if (event is PasswordChanged){

      yield state.copyWith(password: event.password, formStatus: InitialFormStatus());

    }

    else if(event is PasswordVisibilityChanged){

      yield state.copyWith(isPasswordVisible: !state.isPasswordVisible,formStatus: InitialFormStatus());

    }

    else if(event is LoginSubmitted){

      yield state.copyWith(formStatus: FormSubmitting());

      try{

        await authRepository.login(state.username,state.password);
        yield state.copyWith(formStatus: SubmittingSuccess());

      }
      catch(e){
        yield state.copyWith(formStatus: SubmissionFailed(e));
        yield state.copyWith(formStatus: InitialFormStatus());
      }

    }
  }


}