import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pay_split/RouteNames.dart';
import 'package:pay_split/viewmodels/DrawerModel.dart';
import 'package:pay_split/viewmodels/GroupsListViewModel.dart';
import 'package:provider/provider.dart';

class UserCreatedGroupsViewMobile extends StatefulWidget {
  @override
  _UserCreatedGroupsViewMobileState createState() => _UserCreatedGroupsViewMobileState();
}

class _UserCreatedGroupsViewMobileState extends State<UserCreatedGroupsViewMobile> {
  String groupNameEntered = "";
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
                      PopupMenuButton(
                        itemBuilder: (_) => [
                          PopupMenuItem(
                              child: Text(
                                  "Add member"
                              ),
                              value: "/newchat"
                          ),
                          PopupMenuItem(
                              child: Text(
                                  "Add item"
                              ),
                              value: "/new-group-chat"
                          ),
                        ],
                        onSelected: (route) {
                          // Note You must create respective pages for navigation
                          //Navigator.pushNamed(context, route);
                        },
                      )
                    ],
                  )
                ),
                Container(
                  child: StreamProvider.value(
                    value: groupsListViewModel.streamController.stream,
                    initialData: "No groups created yet",
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: groupsListViewModel.groupList.length,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          height: MediaQuery.of(context).size.height*(10/100),
                          child: GestureDetector(
                            child: Card(
                              elevation: 3,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  groupsListViewModel.groupList[index].groupName,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, itemListView, arguments: groupsListViewModel.groupList[index]);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
