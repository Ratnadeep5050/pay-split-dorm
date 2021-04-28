import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:pay_split/models/Group.dart';

class HomeViewModel {

  StreamController<HomeViewModel> streamController = StreamController.broadcast();

  List<Group> groupList = [];

  Group _group = Group.makeObject();

  addGroup(String groupName) {
    Group group = new Group(groupName);
    groupList.add(group);
    streamController.stream.listen((event) {
      event.groupList.add(group);
    });
  }

}