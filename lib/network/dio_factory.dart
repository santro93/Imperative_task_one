import 'package:dio/dio.dart';
import 'package:imperative_task/network/dio_retry_interceptor/retry_interceptor.dart';

class DioFactory {
  static final DioFactory _singleton = DioFactory._internal();
  Dio? dio;
  factory DioFactory() {
    return _singleton;
  }

  DioFactory._internal() {
    dio = Dio();
    dio!.interceptors.add(
      RetryInterceptor(
        dio: dio!,
        retries: 7,
        retryDelays: const [
          Duration(seconds: 10),
          Duration(seconds: 10),
          Duration(seconds: 10),
          Duration(seconds: 10),
          Duration(seconds: 10),
          Duration(seconds: 10),
          Duration(seconds: 10),
        ],
      ),
    );
  }

  Dio getDio() => dio!;
}
