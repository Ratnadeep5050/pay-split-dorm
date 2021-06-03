import 'package:pay_split/models/UserModel.dart';

class Group {
  String groupId = "";
  String groupName = "";
  int numberOfmembers = 0;
  late DateTime groupCreatedAt;
  late String groupCreatorID;
  List groupMembers = [];
  String admin = "";

  Group.makeObject();
  Group(this.groupName);

  static Group fromMapToObject(userDataFromFirestore) {
    Group group = Group.makeObject();

    group.groupId = userDataFromFirestore.id;
    group.groupName = userDataFromFirestore["groupName"];
    group.admin = userDataFromFirestore["admin"];
    group.groupCreatedAt = userDataFromFirestore["groupCreatedAt"].toDate();
    group.groupCreatorID = userDataFromFirestore["groupCreatedBy"];
    group.groupMembers = userDataFromFirestore["groupMembers"];

    return group;
  }

  static Group getGroupDataFromDocumentSnapshotMap(groupDataFromFirestore) {
    Group group = Group.makeObject();

    group.groupId = groupDataFromFirestore.id;
    group.groupName = groupDataFromFirestore["groupName"];
    group.admin = groupDataFromFirestore["admin"];
    group.groupCreatedAt = groupDataFromFirestore["groupCreatedAt"].toDate();
    group.groupCreatorID = groupDataFromFirestore["groupCreatedBy"];
    group.groupMembers = groupDataFromFirestore["groupMembers"];

    return group;

  }

  static List<Group> getGroupDataFromDocumentSnapshotList(List groupDataFromFirestore) {
    List<Group> groupList = [];

    for(var g in groupDataFromFirestore) {
      Group group = Group.getGroupDataFromDocumentSnapshotMap(g);
      groupList.add(group);
    }

    return groupList;
  }
}