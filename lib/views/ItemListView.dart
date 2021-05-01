import 'package:flutter/material.dart';
import 'package:pay_split/models/Group.dart';
import 'package:pay_split/responsive_ui/ScreenTypeLayout.dart';
import 'package:pay_split/responsive_views/item_list_views/ItemListViewMobile.dart';

class ItemListView extends StatefulWidget {
  Group group;

  ItemListView(this.group);

  @override
  _ItemListViewState createState() => _ItemListViewState(this.group);
}

class _ItemListViewState extends State<ItemListView> {
  Group group;

  _ItemListViewState(this.group);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      smallMobile: ItemListViewMobile(this.group),
      mediumMobile: ItemListViewMobile(this.group),
      largeMobile: ItemListViewMobile(this.group),
      smallTablet: ItemListViewMobile(this.group),
      mediumTablet: ItemListViewMobile(this.group),
      desktop: ItemListViewMobile(this.group),
      iPhone8ToXSMax: ItemListViewMobile(this.group),
    );
  }
}
