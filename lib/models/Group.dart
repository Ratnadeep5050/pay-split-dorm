import 'package:pay_split/models/UserModel.dart';

class Group {
  String groupName = "";
  int numberOfmembers = 0;
  late DateTime groupCreatedAt;
  late UserModel groupCreator;
  List<UserModel> groupMembers = [];
  String admin = "";

  Group.makeObject();
  Group(this.groupName);

  static Group getGroupDataFromDocumentSnapshot(Map<String, dynamic> groupDataFromFirestore) {
    //print("In model");
    //print(multiplayerGame);
    Group group = Group.makeObject();

    group.groupName = groupDataFromFirestore["groupName"];
    group.admin = groupDataFromFirestore["admin"];
    group.groupCreatedAt = groupDataFromFirestore["groupCreatedAt"];
    group.groupCreator = groupDataFromFirestore["groupCreatedBy"];
    group.groupMembers = groupDataFromFirestore["groupMembers"];

    return group;

  }
}