import 'package:firebase_auth/firebase_auth.dart';
import 'package:pay_split/models/Group.dart';
import 'package:pay_split/models/UserModel.dart';
import 'package:pay_split/services/CloudFirebaseService.dart';

class Item{
  String itemId = "";
  String itemName = "";
  String itemPrice = "";
  late String itemBoughtById;
  late DateTime itemBoughtAt;
  late String itemGroupId;
  int itemPaymentState = 0;
  List itemPricePaymentStatusByMembers = [];
  Map<String, String> itemPaymentStatusByMembers = {};

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

  toJson() {
    return {
      "userName": itemPaymentStatusByMembers[""],
    };
  }
  /*
  static Map<String, String> dividedPaymentIntoMembers(Item item, Group group) {
    double price = double.parse(item.itemPrice);
    double priceToPayByEachMember = price/group.groupMembers.length;

    for(var m in group.groupMembers) {
      UserModel userModel = UserModel.fromMapToObject(m);
      item.itemPaymentStatusByMembers.update(userModel.phoneNumber, (value) => priceToPayByEachMember.toString());
    }

    return item.itemPaymentStatusByMembers;
  }
  */
}