import 'package:firebase_auth/firebase_auth.dart';
import 'package:pay_split/models/Group.dart';

class UserModel {
  String uid = "";
  String username = "";
  String email = "";
  String password = "";
  String phoneNumber = "";
  String privilege = "";

  List userCreatedGroups = [];
  List groupsUserAddedTo = [];

  List<UserModel> userList = [];

  /*
    User(name: "Sadman", phoneNumber: "000")
    User("Sadman", "000"),
    User("Toorja", "001"),
    User("Samir", "010"),
    User("Anika", "011"),
    User("Jaber", "100"),
    User("Sagol", "101"),
    User("Bolod", "110"),
    User("Gadha", "111"),

     */

  UserModel.makeObject();

  static UserModel getGroupDataFromDocumentSnapshotMap(userDataFromFirestore) {
    UserModel user = UserModel.makeObject();

    user.uid = userDataFromFirestore.id;
    user.username = userDataFromFirestore["username"];
    user.password = userDataFromFirestore["password"];
    user.phoneNumber = userDataFromFirestore["phoneNumber"];
    user.userCreatedGroups = userDataFromFirestore["groupsCreadted"];
    user.groupsUserAddedTo = userDataFromFirestore["groupsUserAddedTo"];

    return user;

  }

  static List<UserModel> getUserDataFromDocumentSnapshotList(List userDataFromFirestore) {
    List<UserModel> userList = [];

    for(var u in userDataFromFirestore) {
      UserModel user = UserModel.getGroupDataFromDocumentSnapshotMap(u);
      userList.add(user);
    }

    return userList;
  }

  static UserModel getUserDataFromDocumentSnapshotListPhoneNumbers(List userDataFromFirestore, String phoneNumber) {
    UserModel user = UserModel.makeObject();

    for(var u in userDataFromFirestore) {
      if(u["phoneNumber"] == phoneNumber) {
        user = UserModel.getGroupDataFromDocumentSnapshotMap(u);
      }
    }

    return user;
  }

  static UserModel getUserDataFromDocumentSnapshot(Map<String, dynamic> userDataFromFirestore) {
    return UserModel(
        userDataFromFirestore["username"],
        userDataFromFirestore["email"],
        userDataFromFirestore["password"],
        userDataFromFirestore["phoneNumber"],
    );
  }

  toJson() {
    return {
      "email": this.email,
      "password": this.password,
      "username": this.username,
      "phoneNumber": this.phoneNumber,
      "groupsCreadted": this.userCreatedGroups,
      "groupsUserAddedTo": this.groupsUserAddedTo
    };
  }

  /*
  addDummyData() {
    userList.add(
        UserModel("Sadman", "000")
    );
    userList.add(
        UserModel("Toorja", "001")
    );
    userList.add(
        UserModel("Samir", "010")
    );
    userList.add(
        UserModel("Anika", "011")
    );
    userList.add(
        UserModel("Jaber", "100")
    );
    userList.add(
        UserModel("Sagol", "101")
    );
    userList.add(
        UserModel("Bolod", "110")
    );
    userList.add(
        UserModel("Gadha", "111")
    );
  }
  */

  UserModel(this.username, this.email, this.password, this.phoneNumber);
}