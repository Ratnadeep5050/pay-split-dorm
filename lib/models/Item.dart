import 'package:pay_split/models/Group.dart';
import 'package:pay_split/models/UserModel.dart';

class Item{
  String itemId = "";
  String itemName = "";
  String itemPrice = "";
  late String itemBoughtById;
  late DateTime itemBoughtAt;
  late String itemGroupId;
  int itemPaymentState = 0;
  List itemPricePaymentStatusByMembers = [];

  Item.makeObject();

  Item(this.itemName, this.itemPrice, this.itemBoughtById, this.itemBoughtAt, this.itemGroupId);

  static Item getItemDataFromDocumentSnapshotMap(itemDataFromFirestore) {
    Item item = Item.makeObject();

    item.itemId = itemDataFromFirestore.id;
    item.itemName = itemDataFromFirestore["itemName"];
    item.itemPrice = itemDataFromFirestore["itemPrice"];
    item.itemBoughtAt = itemDataFromFirestore["itemBoughtAt"].toDate();
    item.itemBoughtById = itemDataFromFirestore["itemBoughtBy"];
    item.itemGroupId = itemDataFromFirestore["itemBelongsToGroup"];

    return item;
  }

  static List<Item> getItemDataFromDocumentSnapshotList(List itemDataFromFirestore, String groupId) {
    List<Item> itemList = [];

    for(var i in itemDataFromFirestore) {
      if(i["itemBelongsToGroup"] == groupId) {
        Item item = Item.getItemDataFromDocumentSnapshotMap(i);
        itemList.add(item);
      }
    }

    return itemList;
  }  
}