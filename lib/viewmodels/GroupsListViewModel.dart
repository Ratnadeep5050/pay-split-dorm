import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:pay_split/models/Group.dart';

class GroupsListViewModel {

  StreamController<GroupsListViewModel> streamController = StreamController.broadcast();

  List<Group> groupList = [];

  addGroup(String groupName) {
    Group group = new Group(groupName);
    groupList.add(group);
    streamController.stream.listen((event) {
      event.groupList.add(group);
    });
  }

}