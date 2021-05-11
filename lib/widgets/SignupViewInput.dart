import 'package:flutter/material.dart';
import 'package:pay_split/widgets/LoginViewButton.dart';
import 'package:pay_split/widgets/LoginViewInputField.dart';
import 'package:pay_split/widgets/SignupViewButton.dart';

class SignupViewInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(height: 40,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: LoginViewInputField(),
            ),
            SizedBox(height: 40,),
            Text(
              "Forgot Password?",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 40,),
            SignupViewButton()
          ],
        ),
      ),
    );
  }
}