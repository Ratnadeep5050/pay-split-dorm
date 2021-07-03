import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  getUserListOfGroup(Group group) async {
    return await _ref.collection("group").doc(group.groupId).get();
        /*
        .then((data) {
      if(data.exists) {
        print("exist");
        print(data.get("groupMembers"));
        return data.get("groupMembers");
      }
      else{
        print("exist");
        return [];
      }
    });

         */
  }

  Future<void> addUserDataToFireStore(UserModel userModel, String userId) {
    return _ref.collection("users").doc(userId).set(userModel.toJson());
  }

  addGroupToFirestore(Group group) async {
    await _ref.collection("groups").add({
      "admin": userModel.uid,
      "groupCreatedAt": DateTime.now(),
      "groupCreatedBy": userModel.uid,
      "groupMembers": FieldValue.arrayUnion([userModel.uid]),
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

  addItemToFirestore(Item item) async {
    await _ref.collection("items").add({
      "itemBelongsToGroup": item.itemGroupId,
      "itemBoughtAt": DateTime.now(),
      "itemBoughtBy": item.itemBoughtById,
      "itemName": item.itemName,
      "itemPaymentStatusByMembers": item.itemPaymentStatusByMembers,
      "itemPrice": item.itemPrice,
      "itemPricePaid": item.itemPricePaid
    });

    //updateItemPricePaidStatus(item);
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

  getPaymentStatusByMembers(Item item) async {
    return await _ref.collection("items").doc(item.itemId).get().then((data) {
      if(data.exists) {
        return data.get("itemPaymentStatusByMembers");
      }
      else {
        return {};
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
    await _ref.collection("groups").doc(groupId).update({
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


  updateItemPaymentStatus(Item item) {
    _ref.collection("items")
        .doc(item.itemId)
        .set(item.itemPaymentStatusByMembers);

    updateItemPricePaidStatus(item);
  }

  updatePaymentStatusByMember(UserModel userModel, Item item) async {
    await _ref.collection("items").doc(item.itemId).update(
      {
        "itemPaymentStatusByMembers.${userModel.phoneNumber}": "0"
      }
    );
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