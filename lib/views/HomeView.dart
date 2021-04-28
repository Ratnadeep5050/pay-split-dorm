import 'package:flutter/material.dart';
import 'package:pay_split/responsive_ui/ScreenTypeLayout.dart';
import 'package:pay_split/responsive_views/HomeViewMobile.dart';
import 'package:pay_split/viewmodels/HomeViewModel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      smallMobile: HomeViewMobile(),
      mediumMobile: HomeViewMobile(),
      largeMobile: HomeViewMobile(),
      smallTablet: HomeViewMobile(),
      mediumTablet: HomeViewMobile(),
      desktop: HomeViewMobile(),
      iPhone8ToXSMax: HomeViewMobile(),
    );
  }
}
