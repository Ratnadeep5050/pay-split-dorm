import 'package:flutter/material.dart';
import 'package:pay_split/services/AuthenticationService.dart';
import 'package:pay_split/viewmodels/AuthenticationViewModel.dart';
import 'package:provider/provider.dart';

class SignupViewButton extends StatelessWidget{
  AuthenticationService _authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    final authenticationViewModel = Provider.of<AuthenticationViewModel>(context);

    return GestureDetector(
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
          color: Colors.cyan[500],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "Sign up",
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
      onTap: () {
        _authenticationService.signUp(authenticationViewModel.email, authenticationViewModel.password);
      },
    );
  }
}