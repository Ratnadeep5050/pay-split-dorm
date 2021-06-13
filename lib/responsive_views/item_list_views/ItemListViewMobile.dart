import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pay_split/RouteNames.dart';
import 'package:pay_split/models/Group.dart';
import 'package:pay_split/models/Item.dart';
import 'package:pay_split/services/CloudFirebaseService.dart';
import 'package:pay_split/viewmodels/GroupsListViewModel.dart';
import 'package:pay_split/viewmodels/ItemsListViewModel.dart';
import 'package:provider/provider.dart';

class ItemListViewMobile extends StatefulWidget {
  Group group;

  ItemListViewMobile(this.group);

  @override
  _ItemListViewMobileState createState() => _ItemListViewMobileState(this.group);
}

class _ItemListViewMobileState extends State<ItemListViewMobile> {
  Group group;
  List<Item> itemList = [];

  _ItemListViewMobileState(this.group);

  @override
  Widget build(BuildContext context) {
    final itemListViewModel = Provider.of<ItemsListViewModel>(context);
    final groupViewModel = Provider.of<GroupsListViewModel>(context);

    groupViewModel.currentGroup = group;

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
                          group.groupName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                      PopupMenuButton(
                        itemBuilder: (_) => [
                          PopupMenuItem(
                              child: Text(
                                  "Add member"
                              ),
                              value: "/addMember"
                          ),
                          PopupMenuItem(
                              child: Text(
                                  "See members"
                              ),
                              value: "/seeMembers"
                          ),
                          PopupMenuItem(
                              child: Text(
                                  "Add item"
                              ),
                              value: "/addItem"
                          ),
                        ],
                        onSelected: (value) {
                          if(value == "/addItem") {
                            _showItemCreateForm(context, itemListViewModel);
                          }
                          else if(value == "/addMember") {
                            Navigator.pushNamed(context, memberSearchView, arguments: group);
                          }
                          else if(value == "/seeMembers") {
                            Navigator.pushNamed(context, memberListView, arguments: group);
                          }
                        },
                      )
                    ],
                  )
              ),
              ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("items").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.hasData) {
                        QuerySnapshot items = snapshot.data;

                        itemList = Item.getItemDataFromDocumentSnapshotList(items.docs, group.groupId);

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: itemList.length,
                          itemBuilder: (BuildContext context, index) {
                            return _getItemCard(index);
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

  _showItemCreateForm(BuildContext context, itemListViewModel) {
    String itemNameEntered = "";
    String itemPrice = "";

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
                height: 230,
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
                          labelText: "Item Name",
                          labelStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                          ),
                        ),
                        onChanged: (text) {
                          itemNameEntered = text;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                          labelText: "Price",
                          labelStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                          ),
                        ),
                        onChanged: (text) {
                          itemPrice = text;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () async {
                        String itemBoughtById = context.read<CloudFirebaseService>().userModel.uid;
                        Item item = new Item(itemNameEntered, itemPrice, itemBoughtById, DateTime.now(), this.group.groupId);

                        context.read<CloudFirebaseService>().addItemToFirestore(item);
                        Navigator.pop(context);
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

  Widget _getItemCard(int index) {
    Item item = itemList[index];

    //print(item);

    return GestureDetector(
      child: Card(
        elevation: 3,
        child: Container(
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
      onTap: () {
        Navigator.pushNamed(context, itemDetailsView, arguments: item);
      },
    );
  }
}
