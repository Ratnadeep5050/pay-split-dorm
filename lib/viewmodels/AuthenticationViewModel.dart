import 'package:flutter/cupertino.dart';

class AuthenticationViewModel extends ChangeNotifier {

  String email = "";
  String password = "";

  emailSubmit(String emailTyped) {
    email = emailTyped;
    notifyListeners();
  }

  passwordSubmit(String passwordTyped) {
    password = passwordTyped;
    notifyListeners();
  }

}