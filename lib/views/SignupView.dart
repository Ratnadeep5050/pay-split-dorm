import 'package:flutter/material.dart';
import '../responsive_views/signup_view/SignupViewMobile.dart';
import 'package:pay_split/responsive_ui/LoginSignupScreenTypeLayout.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    return LoginSignupScreenTypeLayout(
      smallMobile: SignupViewMobile(),
      mediumMobile: SignupViewMobile(),
      largeMobile: SignupViewMobile(),
      smallTablet: SignupViewMobile(),
      mediumTablet: SignupViewMobile(),
      desktop: SignupViewMobile(),
      iPhone8ToXSMax: SignupViewMobile(),
    );
  }
}
