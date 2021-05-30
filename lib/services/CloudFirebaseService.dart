import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pay_split/models/Group.dart';
import 'package:pay_split/models/UserModel.dart';

class CloudFirebaseService {
  FirebaseFirestore _ref = FirebaseFirestore.instance;
  UserModel userModel = UserModel.makeObject();
  UserModel activeUser = UserModel.makeObject();
  StreamController<Group> _streamController = StreamController<Group>.broadcast();

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

  Future<void> addGroupToFirestore(Group group) {
    return _ref.collection("groups").add({
      "admin": userModel.uid,
      "groupCreatedAt": DateTime.now(),
      "groupCreatedBy": userModel.uid,
      "groupMembers": [],
      "groupName": group.groupName,
    });
  }

}