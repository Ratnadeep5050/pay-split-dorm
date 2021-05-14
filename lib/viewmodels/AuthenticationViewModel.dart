import 'package:flutter/cupertino.dart';

class AuthenticationViewModel extends ChangeNotifier {

  String email = "";
  String password = "";
  String username = "";
  String phoneNumber = "";

  emailSubmit(String emailTyped) {
    email = emailTyped;
    notifyListeners();
  }

  usernameSubmit(String usernameTyped) {
    username = usernameTyped;
    notifyListeners();
  }

  phoneNumberSubmit(String phoneNumberTyped) {
    phoneNumber = phoneNumberTyped;
    notifyListeners();
  }

  passwordSubmit(String passwordTyped) {
    password = passwordTyped;
    notifyListeners();
  }

}