import 'package:pay_split/models/UserModel.dart';

class Group {
  String groupName = "";
  int numberOfmembers = 0;
  late DateTime groupCreatedAt;
  late String groupCreatorID;
  List groupMembers = [];
  String admin = "";

  Group.makeObject();
  Group(this.groupName);

  static Group getGroupDataFromDocumentSnapshotMap(groupDataFromFirestore) {
    Group group = Group.makeObject();

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