import 'package:pay_split/models/UserModel.dart';

class Group {
  String groupName = "";
  int numberOfmembers = 0;
  late DateTime groupCreatedAt;
  List<UserModel> groupMembers = [];

  Group(this.groupName);

  Group.makeObject();
}