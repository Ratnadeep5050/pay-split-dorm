import 'package:flutter/material.dart';
import 'package:pay_split/widgets/LoginViewHeader.dart';
import 'package:pay_split/widgets/LoginViewInput.dart';

class LoginViewMobile extends StatefulWidget {
  @override
  _LoginViewMobileState createState() => _LoginViewMobileState();
}

class _LoginViewMobileState extends State<LoginViewMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
            Colors.black,
            Colors.cyan,
            Colors.black
          ]),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 80,),
            LoginViewHeader(),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(60),
                  )
              ),
              child: LoginViewInput(),
            )
            )
          ],
        ),
      ),
    );
  }
}
