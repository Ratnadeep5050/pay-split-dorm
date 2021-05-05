import 'package:pay_split/RouteNames.dart';
import 'package:pay_split/models/Group.dart';
import 'package:pay_split/responsive_views/member_search_views/MemberSearchViewMobile.dart';
import 'package:pay_split/views/ItemListView.dart';
import 'package:pay_split/views/MemberSearchView.dart';
import 'package:pay_split/views/MembersListView.dart';
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
        var group = settings.arguments as Group;
        return MaterialPageRoute(builder: (_) => ItemListView(group));
      case memberSearchView:
        var group = settings.arguments as Group;
        return MaterialPageRoute(builder: (_) => MemberSearchView(group));
      case memberListView:
        var group = settings.arguments as Group;
        return MaterialPageRoute(builder: (_) => MemberListView(group));
    }

    return MaterialPageRoute(builder: (_) => MyApp());
  }
}