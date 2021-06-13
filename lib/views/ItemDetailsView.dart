import 'package:flutter/material.dart';
import 'package:pay_split/models/Group.dart';
import 'package:pay_split/models/Item.dart';
import 'package:pay_split/responsive_ui/ScreenTypeLayout.dart';
import 'package:pay_split/responsive_views/item_list_views/ItemDetailsViewMobile.dart';
import 'package:pay_split/responsive_views/item_list_views/ItemListViewMobile.dart';

class ItemDetailsView extends StatefulWidget {
  Item item;

  ItemDetailsView(this.item);

  @override
  _ItemDetailsViewState createState() => _ItemDetailsViewState(this.item);
}

class _ItemDetailsViewState extends State<ItemDetailsView> {
  Item item;

  _ItemDetailsViewState(this.item);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      smallMobile: ItemDetailsViewMobile(this.item),
      mediumMobile: ItemDetailsViewMobile(this.item),
      largeMobile: ItemDetailsViewMobile(this.item),
      smallTablet: ItemDetailsViewMobile(this.item),
      mediumTablet: ItemDetailsViewMobile(this.item),
      desktop: ItemDetailsViewMobile(this.item),
      iPhone8ToXSMax: ItemDetailsViewMobile(this.item),
    );
  }
}
