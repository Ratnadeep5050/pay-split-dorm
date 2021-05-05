import 'package:flutter/material.dart';
import 'package:pay_split/models/Group.dart';
import 'package:pay_split/models/User.dart';

class MemberSearchViewMobile extends StatefulWidget {
  Group group;

  MemberSearchViewMobile(this.group);

  @override
  _MemberSearchViewMobileState createState() => _MemberSearchViewMobileState(this.group);
}

class _MemberSearchViewMobileState extends State<MemberSearchViewMobile> {
  Group group;

  _MemberSearchViewMobileState(this.group);

  String memberPhoneNumberEntered = "";
  List<User> filteredUsers = [];
  User _user = new User.makeObject();

  @override
  void initState() {
    // TODO: implement initState
    _user.addDummyData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          child: IconTheme(
                            data: IconThemeData(
                              color: Colors.blue[500],
                              size: 35
                            ),
                            child: Icon(
                                Icons.search
                            ),
                          ),
                        padding: EdgeInsets.fromLTRB(7, 3, 2, 10),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(3, 3, 10, 10),
                          child: TextField(
                            cursorColor: Colors.blue,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black
                            ),
                            decoration: InputDecoration(
                              labelText: "Search by phone number",
                              labelStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black
                              ),
                            ),
                            onChanged: (text) {
                              setState(() {
                                filteredUsers = _user.userList
                                    .where((user) => (user.name
                                    .toLowerCase()
                                    .contains(text.toLowerCase()) ||
                                    user.phoneNumber.toLowerCase().contains(text.toLowerCase())))
                                    .toList();
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filteredUsers.length,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        padding: EdgeInsets.all(5),
                        child: Card(
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
                                          filteredUsers[index].name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                          filteredUsers[index].phoneNumber,
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
                              Container(
                                child: IconButton(
                                  icon: Icon(
                                      Icons.add
                                  ),
                                  onPressed: () {
                                    group.groupMembers.add(filteredUsers[index]);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
