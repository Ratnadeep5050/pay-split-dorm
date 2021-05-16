import 'package:flutter/material.dart';
import 'package:pay_split/models/Group.dart';
import 'package:pay_split/responsive_ui/ScreenTypeLayout.dart';
import 'package:pay_split/responsive_views/member_search_views/MemberSearchViewMobile.dart';
import 'package:pay_split/responsive_views/members_list_view/MembersListViewMobile.dart';

class MemberListView extends StatefulWidget {
  Group group;

  MemberListView(this.group);

  @override
  _MemberListViewState createState() => _MemberListViewState(this.group);
}

class _MemberListViewState extends State<MemberListView> {
  Group group;

  _MemberListViewState(this.group);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      smallMobile: MembersListViewMobile(this.group),
      mediumMobile: MembersListViewMobile(this.group),
      largeMobile: MembersListViewMobile(this.group),
      smallTablet: MembersListViewMobile(this.group),
      mediumTablet: MembersListViewMobile(this.group),
      desktop: MembersListViewMobile(this.group),
      iPhone8ToXSMax: MembersListViewMobile(this.group),
    );
  }
}
