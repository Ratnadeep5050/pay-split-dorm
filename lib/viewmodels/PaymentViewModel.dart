import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/Item.dart';
import '../models/Group.dart';
import '../models/UserModel.dart';

class PaymentViewModel with ChangeNotifier{
  double paidAmount = 0;
  List<UserModel> userList = [];
  Item itemModel = Item.makeObject();

  dividePaymentAmongMembers(Item item, Group group, cloudFirebaseService) {
    itemModel = item;
    double price = double.parse(itemModel.itemPrice);
    double priceToPayByEachMember = price/group.groupMembers.length;

    for(var u in userList) {
      itemModel.itemPaymentStatusByMembers[u.phoneNumber] = priceToPayByEachMember.toString();
    }
  }

  updatePaymentStatus(Item item, UserModel userModel, cloudFirebaseService) async {
    itemModel = item;
    itemModel.itemPricePaid = await cloudFirebaseService.getItemPricePaid(item);
    double priceToBePaid = double.parse(itemModel.itemPaymentStatusByMembers[userModel.phoneNumber]!);

    paidAmount = double.parse(itemModel.itemPricePaid);

    if(paidAmount != double.parse(itemModel.itemPrice)) {
      paidAmount += priceToBePaid;
      itemModel.itemPricePaid = paidAmount.toString();
    }

    itemModel.itemPaymentStatusByMembers[userModel.phoneNumber] = "0";
    print(itemModel.itemPaymentStatusByMembers[userModel.phoneNumber]);
    await cloudFirebaseService.updateItemPricePaidStatus(item);

    notifyListeners();
  }
}