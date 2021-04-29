import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pay_split/RouteNames.dart';
import 'package:pay_split/viewmodels/GroupsListViewModel.dart';
import 'package:provider/provider.dart';

class HomeViewMobile extends StatefulWidget {
  @override
  _HomeViewMobileState createState() => _HomeViewMobileState();
}

class _HomeViewMobileState extends State<HomeViewMobile> {
  String groupNameEntered = "";

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<GroupsListViewModel>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(5),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  shadowColor: Colors.blue[900],
                  elevation: 15,
                ),
                child: Text(
                  "Groups you created",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, userCreatedGroupsView);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  shadowColor: Colors.red[900],
                  elevation: 15,
                ),
                child: Text(
                  "Groups you are added",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
                onPressed: () {

                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  shadowColor: Colors.blue[900],
                  elevation: 15,
                ),
                child: Text(
                  "Create group",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
                onPressed: () {
                  _showGroupNameForm(context, homeViewModel);
                },
              ),
            ),
          ],
        ),
      ),
    );
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
                          groupNameEntered = text;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () async {
                        homeViewModel.addGroup(groupNameEntered);
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
