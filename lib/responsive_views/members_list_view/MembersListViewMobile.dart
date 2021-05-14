import 'package:flutter/material.dart';
import 'package:pay_split/models/Group.dart';
import 'package:pay_split/models/UserModel.dart';

class MembersListViewMobile extends StatefulWidget {
  Group group;

  MembersListViewMobile(this.group);

  @override
  _MembersListViewMobileState createState() => _MembersListViewMobileState(this.group);
}

class _MembersListViewMobileState extends State<MembersListViewMobile> {
  Group group;

  _MembersListViewMobileState(this.group);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: ListView.builder(
            itemCount: group.groupMembers.length,
            itemBuilder: (BuildContext context, index) {
              UserModel user = group.groupMembers[index];
              return Container(
                child: Card (
                  elevation: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  user.username,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  user.phoneNumber,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black54
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                      Container()
                    ],
                  ),
                )
              );
            },
          ),
        ),
      ),
    );
  }
}
