import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:imperative_task/network/api_base_helper.dart';
import 'package:imperative_task/network/api_service_urls.dart';
import 'package:imperative_task/shared_preference/shared_preferences.dart';
import 'package:imperative_task/utility/constants/app_constants.dart';

class TranscationRepo {
  factory TranscationRepo() {
    return _this;
  }

  TranscationRepo._();

  static final TranscationRepo _this = TranscationRepo._();

  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  static TranscationRepo get instance => _this;

  // Transaction List
  Future<Response> getTransactionList() async {
    String? token =
        await SharedPreferencesService.getData(StorageKeys.accessToken);
    try {
      var response = await apiBaseHelper.get(
        url: ApiServiceUrls.transactionsList,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        ),
      );
      log(response.data.toString());
      return response;
    } catch (error) {
      throw Exception(
          'Error occurred during Transaction List: ${error.toString()}');
    }
  }
}
