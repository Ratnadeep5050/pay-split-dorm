import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pay_split/RouteNames.dart';
import 'package:pay_split/models/Group.dart';
import 'package:pay_split/models/Item.dart';
import 'package:pay_split/models/UserModel.dart';
import 'package:pay_split/services/CloudFirebaseService.dart';
import 'package:pay_split/viewmodels/GroupsListViewModel.dart';
import 'package:pay_split/viewmodels/PaymentViewModel.dart';
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
  Map<String, String> itemPaymentStatus = {};
  double paymentAmount = 0.0;
  double paidAmount = 0.0;
  List<Map<String, String>> paymentStatusBymembers = [];

  _ItemDetailsViewMobileState(this.item);

  @override
  Widget build(BuildContext context) {
    final cloudFirebaseService = Provider.of<CloudFirebaseService>(context);
    final groupViewModel = Provider.of<GroupsListViewModel>(context);
    final paymentViewModel = Provider.of<PaymentViewModel>(context);

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
                            "${item.itemPricePaid}/${item.itemPrice}",
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
                      future: getUsersById(snapshot.data["groupMembers"], cloudFirebaseService, paymentViewModel),
                      builder: (context, snapShot) {
                        paymentViewModel.dividePaymentAmongMembers(item, group, cloudFirebaseService);
                        if(snapShot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: group.groupMembers.length,
                            itemBuilder: (BuildContext context, index) {
                              return _getMemberCard(index, cloudFirebaseService, paymentViewModel);
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

  Widget _getMemberCard(int index, cloudFirebaseService, paymentViewModel) {
    UserModel user = paymentViewModel.userList[index];

    //print(user.username);

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
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 2, 5, 5),
                      child: Text(
                        paymentViewModel.itemModel.itemPaymentStatusByMembers[user.phoneNumber].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Colors.black54
                        ),
                      ),
                    ),
                    cloudFirebaseService.activeUser.phoneNumber == user.phoneNumber ? Container(
                      margin: EdgeInsets.fromLTRB(5, 2, 5, 5),
                      child: TextButton(
                        child: Text(
                          "Pay",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: Colors.black54
                          ),
                        ),
                        onPressed: () async {
                          /*
                          for(var u in paymentViewModel.userList) {
                            print("Before payment ${u.phoneNumber} => ${paymentViewModel.itemModel.itemPaymentStatusByMembers[u.phoneNumber]}");
                          }

                           */

                          //print(paymentViewModel.itemModel.itemPaymentStatusByMembers[user.phoneNumber]);
                          if(paymentViewModel.itemModel.itemPaymentStatusByMembers[user.phoneNumber] != "0") {
                            await paymentViewModel.updatePaymentStatus(item, user, cloudFirebaseService);
                          }
                          /*
                          for(var u in paymentViewModel.userList) {
                            print("After payment ${u.phoneNumber} => ${paymentViewModel.itemModel.itemPaymentStatusByMembers[u.phoneNumber]}");
                          }

                           */
                        },
                      ),
                    )
                        :
                    Container(
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            )
        )
    );
  }

  getUsersById(snapshot, cloudFirebaseService, paymentViewModel) async {
    await Future.delayed(Duration(seconds: 1));

    for(int i=0; i<group.groupMembers.length; i++) {
      var result = await cloudFirebaseService.getUserById(snapshot[i]);
      UserModel user = UserModel.fromMapToObject(result);
      paymentViewModel.userList.add(user);
      //for(var u in paymentViewModel.userList) {
      //  print(u.userName);
      //}
    }

    return 1;
  }

  _showGroupNameForm(BuildContext context, homeViewModel) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
                height: 130,
                width: 150,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      width: 150,
                      alignment: Alignment.center,
                      child: TextField(
                        cursorColor: Colors.blue,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                        decoration: InputDecoration(
                          labelText: "Enter Group Name",
                          labelStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                          ),
                        ),
                        onChanged: (text) {
                          paymentAmount = double.parse(text);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () async {

                      },
                      child: Text(
                        "Create",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black,
                            fontFamily: "matrixFont"
                        ),
                      ),
                    )
                  ],
                )
            ),
          );
        }
    );
  }
}
