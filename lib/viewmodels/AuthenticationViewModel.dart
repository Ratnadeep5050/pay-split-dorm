import 'package:flutter/cupertino.dart';
import 'package:pay_split/models/UserModel.dart';

class AuthenticationViewModel extends ChangeNotifier {

  UserModel userModel = new UserModel.makeObject();

  emailSubmit(String emailTyped) {
    userModel.email = emailTyped;
    notifyListeners();
  }

  usernameSubmit(String usernameTyped) {
    userModel.username = usernameTyped;
    notifyListeners();
  }

  phoneNumberSubmit(String phoneNumberTyped) {
    userModel.phoneNumber = phoneNumberTyped;
    notifyListeners();
  }

  passwordSubmit(String passwordTyped) {
    userModel.password = passwordTyped;
    notifyListeners();
  }

}