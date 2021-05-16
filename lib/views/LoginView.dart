import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pay_split/responsive_views/login_view/LoginViewMobile.dart';
import 'package:pay_split/responsive_ui/LoginSignupScreenTypeLayout.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return LoginSignupScreenTypeLayout(
      smallMobile: LoginViewMobile(),
      mediumMobile: LoginViewMobile(),
      largeMobile: LoginViewMobile(),
      smallTablet: LoginViewMobile(),
      mediumTablet: LoginViewMobile(),
      desktop: LoginViewMobile(),
      iPhone8ToXSMax: LoginViewMobile(),
    );
  }
}
