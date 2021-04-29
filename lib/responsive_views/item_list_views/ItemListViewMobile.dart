import 'package:flutter/material.dart';
import 'package:pay_split/models/Item.dart';
import 'package:pay_split/viewmodels/GroupsListViewModel.dart';
import 'package:pay_split/viewmodels/ItemsListViewModel.dart';
import 'package:provider/provider.dart';

class ItemListViewMobile extends StatefulWidget {
  @override
  _ItemListViewMobileState createState() => _ItemListViewMobileState();
}

class _ItemListViewMobileState extends State<ItemListViewMobile> {
  @override
  Widget build(BuildContext context) {
    final itemListViewModel = Provider.of<ItemsListViewModel>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: StreamProvider.value(
            value: itemListViewModel.streamController.stream,
            initialData: "No items created yet",
            child: ListView.builder(
              itemCount: itemListViewModel.itemList.length,
              itemBuilder: (BuildContext context, index) {
                return Container(
                  height: MediaQuery.of(context).size.height*(15/100),
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Text(
                            itemListViewModel.itemList[index].itemName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Text(
                            "Price: ${itemListViewModel.itemList[index].itemPrice}",
                            style: TextStyle(
                                fontSize: 15
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Text(
                            itemListViewModel.itemList[index].itemBoughtAt.toString(),
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
                );
              },
            ),
          ),
        ),
        floatingActionButton: IconButton(
          color: Colors.black,
          icon: Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {
            _showItemCreateForm(context, itemListViewModel);
          },
        ),
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
                        Item item = new Item(itemNameEntered, itemPrice, DateTime.now());

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
