import 'package:flutter/material.dart';
import 'package:pay_split/widgets/SignupViewHeader.dart';
import 'package:pay_split/widgets/SignupViewInput.dart';

class SignupViewMobile extends StatefulWidget {
  @override
  _SignupViewMobileState createState() => _SignupViewMobileState();
}

class _SignupViewMobileState extends State<SignupViewMobile> {
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
            SignupViewHeader(),
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(60),
                      )
                  ),
                  child: SignupViewInput(),
                )
            )
          ],
        ),
      ),
    );
  }
}
