import 'package:pay_split/models/Group.dart';

class UserModel {
  String username = "";
  String email = "";
  String password = "";
  String phoneNumber = "";

  List<Group> userCreatedGroups = [];
  List<Group> groupsUserAddedTo = [];

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

  UserModel(this.username, this.phoneNumber);
}