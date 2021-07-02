import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/Item.dart';
import '../models/Group.dart';
import '../models/UserModel.dart';

class PaymentViewModel with ChangeNotifier{
  double paidAmount = 0;
  List<UserModel> userList = [];
  Item itemModel = Item.makeObject();

  Item dividePaymentAmongMembers(Item item, Group group, cloudFirebaseService) {
    itemModel = item;
    double price = double.parse(itemModel.itemPrice);
    double priceToPayByEachMember = price/group.groupMembers.length;

    for(var u in userList) {
      itemModel.itemPaymentStatusByMembers[u.phoneNumber] = priceToPayByEachMember.toString();
    }

    return itemModel;
    updatePaymentStatusByMembersInCloudDB(item, cloudFirebaseService);
  }

  updatePaymentStatus(Item item, UserModel userModel, String priceToPay, cloudFirebaseService) async {
    itemModel = item;
    itemModel.itemPricePaid = await cloudFirebaseService.getItemPricePaid(item);
    double priceToBePaid = double.parse(priceToPay);

    paidAmount = double.parse(itemModel.itemPricePaid);

    if(paidAmount != double.parse(itemModel.itemPrice)) {
      paidAmount += priceToBePaid;
      itemModel.itemPricePaid = paidAmount.toString();
    }

    itemModel.itemPaymentStatusByMembers[userModel.phoneNumber] = "0";
    await cloudFirebaseService.updateItemPricePaidStatus(item);

    notifyListeners();
  }

  updatePaymentStatusByMembersInCloudDB(Item item, cloudFirebaseService) async {
    await cloudFirebaseService.updateItemPaymentStatus(item);
  }

  updatePaymentByMember(UserModel userModel, Item item, cloudFirebaseService) async {
    await cloudFirebaseService.updatePaymentStatusByMember(userModel, item);
  }

  getPaymentStatusByMembersFromCloudDB(Item item, cloudFirebaseService) async {
    Map<String, String> itemPaymentStatusByMembers = await cloudFirebaseService.getPaymentStatusByMembers(item);
    return itemPaymentStatusByMembers;
  }
}