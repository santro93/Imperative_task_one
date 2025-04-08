import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  static Future<bool> authenticateUser() async {
    //initialize Local Authentication plugin.
    final LocalAuthentication _localAuthentication = LocalAuthentication();

    //status of authentication.
    bool isAuthenticated = false;

    //check if device supports biometrics authentication.
    bool isBiometricSupported = await _localAuthentication.isDeviceSupported();

    List<BiometricType> biometricTypes =
        await _localAuthentication.getAvailableBiometrics();

    print(biometricTypes);

    //if device supports biometrics, then authenticate.
    if (isBiometricSupported) {
      try {
        isAuthenticated = await _localAuthentication.authenticate(
          localizedReason: 'To continue, you must complete the biometrics',
          options: const AuthenticationOptions(
              biometricOnly: true,
              useErrorDialogs: true,
              stickyAuth: false,
              sensitiveTransaction: false),
        );
      } on PlatformException catch (e) {
        print(e);
      }
    } else {
      Fluttertoast.showToast(
          msg: "This Device does not  Support Biometric ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
    return isAuthenticated;
  }

  static Future<bool> deviceSupportedAuthenticate() async {
    //initialize Local Authentication plugin.
    final LocalAuthentication _localAuthentication = LocalAuthentication();
    bool isAuthenticated = false;
    bool isBiometricSupported = await _localAuthentication.isDeviceSupported();

    if (isBiometricSupported) {
      try {
        isAuthenticated = true;
      } on PlatformException catch (e) {
        isAuthenticated = false;
        print(e);
      }
    } else {
      isAuthenticated = false;
    }
    return isAuthenticated;
  }
}
