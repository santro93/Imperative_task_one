import 'package:imperative_task/utility/constants/network_constants.dart';

class ScreenState {
  String? errorCode;
  String? _errorMsg;

  bool isInvalidException = false;

  set errorMsg(String message) {
    _errorMsg = message;
  }

  String get errorMsg {
    if (errorCode != null &&
        errorCode == NetworkConstants.ERROR_UNABLE_TO_RESOLVE_SERVICE) {
      return NetworkConstants.NO_NETWORK_ERROR;
    }
    return _errorMsg!;
  }
}
