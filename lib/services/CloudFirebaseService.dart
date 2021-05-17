import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pay_split/models/UserModel.dart';

class CloudFirebaseService {
  FirebaseFirestore _ref = FirebaseFirestore.instance;
  UserModel userModel = UserModel.makeObject();

  getUserDataFromFirestore() async {
    DocumentSnapshot documentSnapshot = await _ref.collection("users").doc(userModel.uid).get();
    print(documentSnapshot.data()["email"]);
  }
}