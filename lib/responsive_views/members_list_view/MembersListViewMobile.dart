import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pay_split/models/Group.dart';
import 'package:pay_split/models/UserModel.dart';
import 'package:pay_split/services/CloudFirebaseService.dart';
import 'package:provider/provider.dart';

class MembersListViewMobile extends StatefulWidget {
  Group group;

  MembersListViewMobile(this.group);

  @override
  _MembersListViewMobileState createState() => _MembersListViewMobileState(this.group);
}

class _MembersListViewMobileState extends State<MembersListViewMobile> {
  Group group;
  List<UserModel> userList = [];

  _MembersListViewMobileState(this.group);

  @override
  Widget build(BuildContext context) {
    final cloudFirebaseService = Provider.of<CloudFirebaseService>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("groups").doc(group.groupId).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData) {

                getUsersById(snapshot, cloudFirebaseService);

                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (BuildContext context, index) {
                    return _getMemberCard(index);
                  },
                );
              }
              else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          /*
          ListView.builder(
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
        */
        ),
      ),
    );
  }

  Widget _getMemberCard(int index) {
    UserModel user = userList[index];

    return Container(
        padding: EdgeInsets.all(5),
        child: Card(
            elevation: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      child: Text(
                        user.username,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
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
                ),
                Container(),
              ],
            )
        )
    );
  }

  getUsersById(snapshot, cloudFirebaseService) async {
    for(int i=0; i<2; i++) {
      var user = await cloudFirebaseService.getUserById(snapshot.data["groupMembers"][i]);
      print("Here is user: $user");
    }
  }
}
