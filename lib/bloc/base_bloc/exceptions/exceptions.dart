class BaseException implements Exception {
  late String message;
  late String code;

  BaseException(this.message, this.code);
}

class InvalidException implements Exception {
  late String code;
  late String msg;

  InvalidException(String code, String msg) {
    this.code = code;
    this.msg = msg;
  }
}

class FailedException implements Exception {
  late String code;
  late String msg;
  late Map data;

  FailedException(String code, String msg, Map data) {
    this.code = code;
    this.msg = msg;
    this.data = data;
  }
}

class ServiceException implements Exception {
  late String code;
  late String msg;

  ServiceException(String code, String msg, Map data) {
    this.code = code;
    this.msg = msg;
  }
}
