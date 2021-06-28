import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pay_split/models/Group.dart';
import 'package:pay_split/models/Item.dart';
import 'package:pay_split/models/UserModel.dart';

class CloudFirebaseService {
  FirebaseFirestore _ref = FirebaseFirestore.instance;
  UserModel userModel = UserModel.makeObject();
  UserModel activeUser = UserModel.makeObject();
  StreamController<Item> _streamController = StreamController<Item>.broadcast();

  getUserDataFromFirestore() async {
    print("Auth UID Cloud: ${userModel.uid}");
    DocumentSnapshot userDocument = await _ref.collection("users").doc(userModel.uid).get();

    activeUser = UserModel(
        userDocument.get("username"),
        userDocument.get("email"),
        userDocument.get("password"),
        userDocument.get("phoneNumber"),
    );
  }

  Future<void> addUserDataToFireStore(UserModel userModel, String userId) {
    return _ref.collection("users").doc(userId).set(userModel.toJson());
  }

  addGroupToFirestore(Group group) {
    _ref.collection("groups").add({
      "admin": userModel.uid,
      "groupCreatedAt": DateTime.now(),
      "groupCreatedBy": userModel.uid,
      "groupMembers": [],
      "groupName": group.groupName,
    });

    getGroupsCreatedByUser(userModel.uid);
  }

  getGroupsCreatedByUser(String userId) {
    return _ref.collection("groups")
        .where("groupCreatedBy", isEqualTo: userId)
        .get()
        .then((groups) {
          addGroupsCreatedByUserToUserModel(groups.docs);
        });
  }

  addGroupsCreatedByUserToUserModel(groups) {
    for(var g in groups) {
      activeUser.userCreatedGroups.add(g.id);
    }
    updateUserDataToFireStore(activeUser, userModel.uid);
  }

  Future<void> updateUserDataToFireStore(UserModel userModel, String userId) {
    return _ref.collection("users").doc(userId).set(userModel.toJson());
  }

  Future<void> addItemToFirestore(Item item) {
    return _ref.collection("items").add({
      "itemBelongsToGroup": item.itemGroupId,
      "itemBoughtAt": DateTime.now(),
      "itemBoughtBy": item.itemBoughtById,
      "itemName": item.itemName,
      "itemPaymentStatusByMembers": [],
      "itemPrice": item.itemPrice,
      "itemPricePaid": item.itemPricePaid
    });
  }

  Future<void> updateItemPricePaidStatus(Item item) {
    return _ref.collection("items").doc(item.itemId).update({
      "itemPricePaid": item.itemPricePaid
    });
  }

  Future<String> getItemPricePaid(Item item) async {
    return await _ref.collection("items").doc(item.itemId).get().then((data) {
      if(data.exists) {
        return data.get("itemPricePaid");
      }
      else {
        return "0";
      }
    });
  }
  
  Future getUserById(String userId) async {
    return await _ref.collection("users").doc(userId).get();
  }

  Future getGroupById(String userId) async {
    return await _ref.collection("groups").doc(userId).get();
  }

  addMemberToSpecificGroup(String groupId, UserModel user) async {
    _ref.collection("groups").doc(groupId).update({
      "groupMembers": FieldValue.arrayUnion([user.uid]),
    });

    addGroupIdUserAddedToUserModel(user.uid, groupId);
  }

  addGroupIdUserAddedToUserModel(String userId, String groupId) {
    _ref.collection("users")
        .doc(userId)
        .get()
        .then((user) {
          _ref.collection("users").doc(user.id).update({
            "groupsUserAddedTo": FieldValue.arrayUnion([groupId])
          });
        });
  }


  updateItemPaymentStatus(Item item, UserModel userModel,  List<Map<String, String>> itemPaymentByMember) {
    _ref.collection("items")
        .doc(item.itemId)
        .get()
        .then((user) {
          print(itemPaymentByMember);
      _ref.collection("items").doc(item.itemId).update({
        "itemPaymentStatusByList": itemPaymentByMember
      });
    });

    updateItemPricePaidStatus(item);
  }

  Future getPaymentStatus(Item item) async {
    Map<String, String> itemPaymentStatus = {};

    await _ref.collection("items")
        .doc(item.itemId)
        .get()
        .then((item) {
          itemPaymentStatus = item["itemPaymentStatusByMembers"];
        });

    return itemPaymentStatus;
  }

  Future getSpecificGroup(String groupId) async {
    return await _ref.collection("groups").doc(groupId).get();
  }

}