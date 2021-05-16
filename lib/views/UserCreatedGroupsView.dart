import 'package:flutter/material.dart';
import 'package:pay_split/responsive_ui/ScreenTypeLayout.dart';
import 'package:pay_split/responsive_views/groups_list/UserCreatedGroupsViewMobile.dart';

class UserCreatedGroupsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      smallMobile: UserCreatedGroupsViewMobile(),
      mediumMobile: UserCreatedGroupsViewMobile(),
      largeMobile: UserCreatedGroupsViewMobile(),
      smallTablet: UserCreatedGroupsViewMobile(),
      mediumTablet: UserCreatedGroupsViewMobile(),
      desktop: UserCreatedGroupsViewMobile(),
      iPhone8ToXSMax: UserCreatedGroupsViewMobile(),
    );
  }
}
