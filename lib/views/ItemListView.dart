import 'package:flutter/material.dart';
import 'package:pay_split/responsive_ui/ScreenTypeLayout.dart';
import 'package:pay_split/responsive_views/item_list_views/ItemListViewMobile.dart';

class ItemListView extends StatefulWidget {
  @override
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      smallMobile: ItemListViewMobile(),
      mediumMobile: ItemListViewMobile(),
      largeMobile: ItemListViewMobile(),
      smallTablet: ItemListViewMobile(),
      mediumTablet: ItemListViewMobile(),
      desktop: ItemListViewMobile(),
      iPhone8ToXSMax: ItemListViewMobile(),
    );
  }
}
