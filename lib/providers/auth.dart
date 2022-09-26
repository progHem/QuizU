import 'package:flutter/widgets.dart';

class Phone with ChangeNotifier {
  bool isValid = false;
  String phone = '';

  updatePhone(newPhone) {
    phone = '0$newPhone';
    notifyListeners();
  }

  changeValid() {
    isValid = !isValid;
    notifyListeners();
  }

  setToFalse() {
    isValid = false;

    notifyListeners();
  }
}

class OtpClass with ChangeNotifier {
  bool isValid = false;
  String otpCode = '';

  updateOtpCode(newOtpCode) {
    otpCode = newOtpCode;

    notifyListeners();
  }

  changeValid() {
    isValid = !isValid;
    notifyListeners();
  }

  setToFalse() {
    isValid = false;
    notifyListeners();
  }
}

class User with ChangeNotifier {
  bool validate = false;
  String username = '';

  updateOtpCode(newName) {
    username = newName;
    notifyListeners();
  }

  changeValid() {
    validate = true;
    notifyListeners();
  }

  setToFalse() {
    validate = false;
    notifyListeners();
  }
}
