import 'package:pay_split/models/User.dart';

class Group {
  String groupName = "";
  int numberOfmembers = 0;
  List<User> groupMembers = [];

  Group(this.groupName);

  Group.makeObject();
}