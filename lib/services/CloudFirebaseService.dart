import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pay_split/models/UserModel.dart';

class CloudFirebaseService {
  FirebaseFirestore _ref = FirebaseFirestore.instance;
  UserModel userModel = UserModel.makeObject();
  UserModel activeUser = UserModel.makeObject();

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
}