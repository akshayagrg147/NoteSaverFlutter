import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:io';

class FingerPrint {

  void authenticate() async {
    late final LocalAuthentication auth = LocalAuthentication();
    try {
      bool authorized = await auth.authenticate(
        localizedReason:
        'Login to Proceed',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
      if (authorized == false) {
        exit(0);
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }
}