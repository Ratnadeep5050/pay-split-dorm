import 'package:flutter/material.dart';
import 'package:pay_split/responsive_ui/ScreenTypeLayout.dart';
import 'package:pay_split/responsive_views/login_view/LoginViewMobile.dart';
import '../responsive_views/signup_view/SignupViewMobile.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      smallMobile: SignupViewMobile(),
      mediumMobile: SignupViewMobile(),
      largeMobile: SignupViewMobile(),
      smallTablet: SignupViewMobile(),
      mediumTablet: SignupViewMobile(),
      desktop: SignupViewMobile(),
      iPhone8ToXSMax: SignupViewMobile(),
      loginSignUpView: true,
    );
  }
}
