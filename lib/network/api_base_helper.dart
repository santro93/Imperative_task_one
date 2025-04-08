import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:imperative_task/network/dio_factory.dart';
import 'package:imperative_task/network/network_exception.dart';

class ApiBaseHelper {
  DioFactory dioFactory = DioFactory();

  Future<Response> post({
    required String url,
    dynamic data,
    Options? options,
  }) async {
    try {
      final dio = dioFactory.getDio();
      final response = await dio.post(
        url,
        data: data,
        options: options,
      );
      return response;
    } on DioException catch (ex) {
      if (ex.response != null) {
        throw Exception('DioError: ${ex.response?.data}');
      } else {
        throw Exception('No Internet connection');
      }
    } catch (e) {
      log('Unexpected error occurred: $e');
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  Future<Response> get({
    required String url,
    Options? options,
  }) async {
    try {
      final response = await dioFactory.getDio().get(
            url,
            options: options,
          );
      return _returnResponse(response);
    } on DioException catch (ex) {
      return _returnResponse(ex.response);
    } on Exception {
      throw FetchDataException('No Internet connection');
    }
  }
}

Response _returnResponse(Response? response) {
  switch (response!.statusCode) {
    case 200:
      return response;
    case 400:
      throw BadRequestException(response.data.toString());
    case 401:
    case 403:
      var responseJson = response.data;
      throw UnauthorisedException(responseJson["message"].toString());
    case 500:
    default:
      throw FetchDataException('Error occurred while Communication with '
          'Server with StatusCode : ${response.statusCode}');
  }
}
