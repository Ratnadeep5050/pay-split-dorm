import 'package:pay_split/RouteNames.dart';
import 'package:pay_split/models/Group.dart';
import 'package:pay_split/models/Item.dart';
import 'package:pay_split/responsive_views/groups_list/UserAddedGroupsViewMobile.dart';
import 'package:pay_split/responsive_views/member_search_views/MemberSearchViewMobile.dart';
import 'package:pay_split/views/ItemDetailsView.dart';
import 'package:pay_split/views/ItemListView.dart';
import 'package:pay_split/views/MemberSearchView.dart';
import 'package:pay_split/views/MembersListView.dart';
import 'package:pay_split/views/SignupView.dart';
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
      case userAddedGroupsView:
        return MaterialPageRoute(builder: (_) => UserAddedGroupsViewMobile());
      case itemListView:
        var group = settings.arguments as Group;
        return MaterialPageRoute(builder: (_) => ItemListView(group));
      case itemDetailsView:
        var item = settings.arguments as Item;
        //var group = settings.arguments as Group;
        return MaterialPageRoute(builder: (_) => ItemDetailsView(item));
      case memberSearchView:
        var group = settings.arguments as Group;
        return MaterialPageRoute(builder: (_) => MemberSearchView(group));
      case memberListView:
        var group = settings.arguments as Group;
        return MaterialPageRoute(builder: (_) => MemberListView(group));
      case signupView:
        return MaterialPageRoute(builder: (_) => SignupView());
    }

    return MaterialPageRoute(builder: (_) => MyApp());
  }
}