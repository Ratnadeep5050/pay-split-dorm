import 'package:flutter/material.dart';
import 'package:pay_split/viewmodels/HomeViewModel.dart';
import 'package:provider/provider.dart';

class HomeViewMobile extends StatefulWidget {
  @override
  _HomeViewMobileState createState() => _HomeViewMobileState();
}

class _HomeViewMobileState extends State<HomeViewMobile> {
  String groupNameEntered = "";
  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
        body: Container(
          child: StreamProvider.value(
            value: homeViewModel.streamController.stream,
            initialData: "No groups created yet",
            child: ListView.builder(
              itemCount: homeViewModel.groupList.length,
              itemBuilder: (BuildContext context, index) {
                return Container(
                  height: MediaQuery.of(context).size.height*(10/100),
                  child: Card(
                    elevation: 3,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        homeViewModel.groupList[index].groupName,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
              Icons.add
          ),
          onPressed: () {
            _showGroupNameForm(context, homeViewModel);
          },
        )
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
