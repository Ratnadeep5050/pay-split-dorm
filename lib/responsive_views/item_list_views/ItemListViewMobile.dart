import 'package:flutter/material.dart';
import 'package:pay_split/RouteNames.dart';
import 'package:pay_split/models/Group.dart';
import 'package:pay_split/models/Item.dart';
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

  _ItemListViewMobileState(this.group);

  @override
  Widget build(BuildContext context) {
    final itemListViewModel = Provider.of<ItemsListViewModel>(context);

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
              Container(
                height: MediaQuery.of(context).size.height*(15/100),
                child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Text(
                            "Dummy",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Text(
                            "Dummy Price",
                            style: TextStyle(
                                fontSize: 15
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Text(
                            "Dummy Time",
                            style: TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: Colors.black54
                            ),
                          ),
                        )
                      ],
                    )
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  _showItemCreateForm(BuildContext context, itemListViewModel) {
    String itemNameEntered = "";
    double itemPrice = 0;

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
                          itemPrice = double.parse(text);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () async {
                        Item item = new Item(itemNameEntered, itemPrice, DateTime.now(), this.group);

                        itemListViewModel.addGroup(item);
                        setState(() {

                        });

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
}
