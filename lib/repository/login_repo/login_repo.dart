import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:imperative_task/network/api_base_helper.dart';
import 'package:imperative_task/network/api_service_urls.dart';

class LoginRepository {
  // Singleton pattern
  factory LoginRepository() {
    return _this;
  }

  LoginRepository._();

  static final LoginRepository _this = LoginRepository._();

  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  static LoginRepository get instance => _this;

  // Login API method using FormData
  Future<Response> loginApi(Map<String, dynamic> body) async {
    try {
      var response = await apiBaseHelper.post(
        url: ApiServiceUrls.login,
        data: jsonEncode(body),
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'text/plain', // Match curl
          },
        ),
      );
      log(response.data
          .toString()); // avoid directly using response.data if it's a Map
      return response;
    } catch (error) {
      throw Exception('Error occurred during login: ${error.toString()}');
    }
  }
}
