import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pay_split/RouteNames.dart';
import 'package:pay_split/models/Group.dart';
import 'package:pay_split/models/Item.dart';
import 'package:pay_split/models/UserModel.dart';
import 'package:pay_split/services/CloudFirebaseService.dart';
import 'package:pay_split/viewmodels/GroupsListViewModel.dart';
import 'package:provider/provider.dart';

class ItemDetailsViewMobile extends StatefulWidget {
  Item item;

  ItemDetailsViewMobile(this.item);

  @override
  _ItemDetailsViewMobileState createState() => _ItemDetailsViewMobileState(this.item);
}

class _ItemDetailsViewMobileState extends State<ItemDetailsViewMobile> {
  Item item;
  late Group group;
  List<UserModel> userList = [];

  _ItemDetailsViewMobileState(this.item);

  @override
  Widget build(BuildContext context) {
    final cloudFirebaseService = Provider.of<CloudFirebaseService>(context);
    final groupViewModel = Provider.of<GroupsListViewModel>(context);

    group = groupViewModel.currentGroup;

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                child: Card(
                  elevation: 3,
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            item.itemName,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          child: Text(
                            item.itemPrice.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          child: Text(
                            item.itemBoughtAt.toIso8601String(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                width: double.maxFinite,
                child: Divider(
                  color: Colors.black,
                  height: 10,
                  thickness: 5,
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("groups").doc(group.groupId).snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData) {
                    return FutureBuilder(
                      future: getUsersById(snapshot.data["groupMembers"], cloudFirebaseService),
                      builder: (context, snapShot) {
                        if(snapShot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: group.groupMembers.length,
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
                    );
                  }
                  else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getMemberCard(int index) {
    UserModel user = userList[index];

    print(user.username);

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
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 2),
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
                      margin: EdgeInsets.fromLTRB(5, 2, 5, 5),
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
    await Future.delayed(Duration(seconds: 1));

    for(int i=0; i<group.groupMembers.length; i++) {
      var result = await cloudFirebaseService.getUserById(snapshot[i]);
      UserModel user = UserModel.fromMapToObject(result);
      addUsersToList(user);
    }

    return 1;
  }

  addUsersToList(UserModel user) {
    userList.add(user);
  }
}
