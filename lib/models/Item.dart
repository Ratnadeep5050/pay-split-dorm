import 'package:pay_split/models/Group.dart';
import 'package:pay_split/models/UserModel.dart';

class Item{
  String itemName = "";
  double itemPrice = 0;
  late UserModel itemBoughtBy;
  late DateTime itemBoughtAt;
  late Group itemGroup;
  int itemPaymentState = 0;
  List itemPricePaymentStatus = [];

  Item(this.itemName, this.itemPrice, this.itemBoughtAt, this.itemGroup);
}