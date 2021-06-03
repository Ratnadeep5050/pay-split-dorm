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
      userModel.userCreatedGroups.add(g.id);
    }
    updateUserDataToFireStore(userModel, userModel.uid);
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
    });
  }

  Future getUserById(String userId) async {
    return await _ref.collection("users").doc(userId).get();
  }

  Future<void> addMemberToSpecificGroup(String groupId, UserModel user) async {
    return _ref.collection("groups").doc(groupId).update({
      "groupMembers": FieldValue.arrayUnion([user.uid]),
    });
  }

  Future getSpecificGroup(String groupId) async {
    return await _ref.collection("groups").doc(groupId).get();
  }

}