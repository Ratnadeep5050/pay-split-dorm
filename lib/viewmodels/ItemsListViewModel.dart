import 'dart:async';
import 'package:pay_split/models/Item.dart';

class ItemsListViewModel {

  StreamController<ItemsListViewModel> streamController = StreamController.broadcast();

  List<Item> itemList = [];

  addGroup(Item item) {
    itemList.add(item);
    streamController.stream.listen((event) {
      event.itemList.add(item);
    });
  }

}