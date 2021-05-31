import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pay_split/RouteNames.dart';
import 'package:pay_split/viewmodels/DrawerModel.dart';
import 'package:pay_split/models/Group.dart';
import 'package:pay_split/viewmodels/GroupsListViewModel.dart';
import 'package:provider/provider.dart';

class UserCreatedGroupsViewMobile extends StatefulWidget {
  @override
  _UserCreatedGroupsViewMobileState createState() => _UserCreatedGroupsViewMobileState();
}

class _UserCreatedGroupsViewMobileState extends State<UserCreatedGroupsViewMobile> {
  String groupNameEntered = "";
  List<Group> groupList = [];

  @override
  Widget build(BuildContext context) {
    final groupsListViewModel = Provider.of<GroupsListViewModel>(context);

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
                      stream: FirebaseFirestore.instance.collection("groups").snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData) {
                          QuerySnapshot groups = snapshot.data;

                          groupList = Group.getGroupDataFromDocumentSnapshotList(groups.docs);

                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: groupList.length,
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
}
