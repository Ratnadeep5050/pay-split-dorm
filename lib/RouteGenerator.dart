import 'package:pay_split/RouteNames.dart';
import 'package:pay_split/views/ItemListView.dart';
import 'package:pay_split/views/UserCreatedGroupsView.dart';

import 'main.dart';
import 'package:flutter/material.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => MyApp());
      case userCreatedGroupsView:
        return MaterialPageRoute(builder: (_) => UserCreatedGroupsView());
      case itemListView:
        return MaterialPageRoute(builder: (_) => ItemListView());
    }

    return MaterialPageRoute(builder: (_) => MyApp());
  }
}