import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:imperative_task/bloc/base_bloc/base_bloc.dart';
import 'package:imperative_task/model/login/login_model.dart';
import 'package:imperative_task/repository/login_repo/login_repo.dart';
import 'package:imperative_task/shared_preference/shared_preferences.dart';
import 'package:imperative_task/utility/constants/app_constants.dart';
import '../base_bloc/screen_state.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  LoginState getErrorState() => LoginFailedState();

  @override
  Stream<LoginState> handleEvents(LoginEvent event) async* {
    if (event is LoginDataEvent) {
      yield* _handleLoginEvent(event);
    }
  }

  Stream<LoginState> _handleLoginEvent(LoginDataEvent event) async* {
    yield LoginsProgressState();

    try {
      Map<String, dynamic> body = {
        "username": event.email,
        "password": event.password,
      };
      final Response response = await LoginRepository().loginApi(body);
      if (response.statusCode == 200 && response.data != null) {
        final loginModel = LoginModel.fromJson(response.data);
        if (loginModel.token != null && loginModel.token!.isNotEmpty) {
          final token = loginModel.token!.replaceFirst('Bearer ', '');
          await SharedPreferencesService.saveData(
            StorageKeys.accessToken,
            token,
          );
          final savedToken =
              await SharedPreferencesService.getData(StorageKeys.accessToken);
          log('Saved Access Token: $savedToken');
          yield LoginDataSucessState(loginModel);
        }
      } else {
        throw Exception("Login failed with status: ${response.statusCode}");
      }
    } catch (ex) {
      yield LoginDataFailedState(
          "Error occurred during login: ${ex.toString()}");
    }
  }
}
