import 'package:flutter/material.dart';
import 'package:pay_split/services/AuthenticationService.dart';
import 'package:pay_split/viewmodels/AuthenticationViewModel.dart';
import 'package:provider/provider.dart';

class LoginViewButton extends StatelessWidget{
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
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold
          ),
          ),
        ),
      ),
      onTap: () {
        context.read<AuthenticationService>().signIn(authenticationViewModel.email, authenticationViewModel.password);
      },
    );
  }
}