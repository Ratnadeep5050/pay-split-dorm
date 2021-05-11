import 'package:flutter/material.dart';
import 'package:pay_split/models/Group.dart';
import 'package:pay_split/responsive_ui/ScreenTypeLayout.dart';
import 'package:pay_split/responsive_views/item_list_views/ItemListViewMobile.dart';
import 'package:pay_split/responsive_views/member_search_views/MemberSearchViewMobile.dart';

class MemberSearchView extends StatefulWidget {
  Group group;

  MemberSearchView(this.group);

  @override
  _MemberSearchViewState createState() => _MemberSearchViewState(this.group);
}

class _MemberSearchViewState extends State<MemberSearchView> {
  Group group;

  _MemberSearchViewState(this.group);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      smallMobile: MemberSearchViewMobile(this.group),
      mediumMobile: MemberSearchViewMobile(this.group),
      largeMobile: MemberSearchViewMobile(this.group),
      smallTablet: MemberSearchViewMobile(this.group),
      mediumTablet: MemberSearchViewMobile(this.group),
      desktop: MemberSearchViewMobile(this.group),
      iPhone8ToXSMax: MemberSearchViewMobile(this.group),
      loginSignUpView: false,
    );
  }
}
