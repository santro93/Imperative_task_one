part of 'login_bloc.dart';

abstract class LoginState extends ScreenState {}

// Login
class LoginInitial extends LoginState {}

class LoginFailedState extends LoginState {}

class LoginsProgressState extends LoginState {}

class LoginDataSucessState extends LoginState {
  final LoginModel loginModel;

  LoginDataSucessState(this.loginModel);
}

class LoginDataFailedState extends LoginState {
  final String message;

  LoginDataFailedState(this.message);
}
