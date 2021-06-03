import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pay_split/RouteNames.dart';
import 'package:pay_split/models/UserModel.dart';
import 'package:pay_split/services/CloudFirebaseService.dart';
import 'package:pay_split/viewmodels/DrawerModel.dart';
import 'package:pay_split/models/Group.dart';
import 'package:pay_split/viewmodels/GroupsListViewModel.dart';
import 'package:provider/provider.dart';

class UserAddedGroupsViewMobile extends StatefulWidget {
  @override
  _UserAddedGroupsViewMobileState createState() => _UserAddedGroupsViewMobileState();
}

class _UserAddedGroupsViewMobileState extends State<UserAddedGroupsViewMobile> {
  String groupNameEntered = "";
  List<Group> groupList = [];

  @override
  Widget build(BuildContext context) {
    final groupsListViewModel = Provider.of<GroupsListViewModel>(context);
    final cloudFirebaseService = Provider.of<CloudFirebaseService>(context);

    return SafeArea(
      child: Scaffold(
          body: Container(
            height: double.maxFinite,
            child: Column(
              children: [
                Card(
                    elevation: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Groups",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                      ],
                    )
                ),
                ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(cloudFirebaseService.userModel.uid)
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData) {
                          print(snapshot.data);

                          UserModel userModel = UserModel.fromMapToObject(snapshot.data);

                          getGroupsById(userModel, cloudFirebaseService);

                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: userModel.groupsUserAddedTo.length,
                            itemBuilder: (BuildContext context, index) {
                              return _getGroupCard(index);
                            },
                          );
                        }
                        else {
                          return Center(
                              child: CircularProgressIndicator()
                          );
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          )
      ),
    );
  }

  Widget _getGroupCard(int index) {
    Group group = groupList[index];

    return GestureDetector(
      child: Card(
        elevation: 3,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Text(
            group.groupName,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, itemListView, arguments: groupList[index]);
      },
    );
  }

  getGroupsById(UserModel userModel, cloudFirebaseService) async {
    for(int i=0; i<userModel.groupsUserAddedTo.length; i++) {
      var result = await cloudFirebaseService.getGroupById(userModel.groupsUserAddedTo[i]);
      Group group = Group.fromMapToObject(result);
      groupList.add(group);
    }
  }
}
