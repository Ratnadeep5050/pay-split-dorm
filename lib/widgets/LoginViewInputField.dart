import 'package:flutter/material.dart';
import 'package:pay_split/viewmodels/AuthenticationViewModel.dart';
import 'package:provider/provider.dart';

class LoginViewInputField extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final authenticationViewModel = Provider.of<AuthenticationViewModel>(context);

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey)
              )
          ),
          child: TextField(
            decoration: InputDecoration(
                hintText: "Enter your email",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none
            ),
            onChanged: (email) {
              authenticationViewModel.emailSubmit(email);
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey)
              )
          ),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                hintText: "Enter your password",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none
            ),
            onChanged: (password) {
              authenticationViewModel.passwordSubmit(password);
            },
          ),
        ),
      ],
    );
  }
}