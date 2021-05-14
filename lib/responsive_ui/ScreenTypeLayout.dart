import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pay_split/responsive_ui/ResponsiveBuilder.dart';
import 'package:pay_split/services/AuthenticationService.dart';
import 'package:pay_split/viewmodels/DrawerModel.dart';
import 'package:provider/provider.dart';
import '../enums/DeviceScreenType.dart';

class ScreenTypeLayout extends StatefulWidget {
  final Widget smallMobile;
  final Widget mediumMobile;
  final Widget largeMobile;
  final Widget smallTablet;
  final Widget mediumTablet;
  final Widget desktop;
  final Widget iPhone8ToXSMax;
  final bool loginSignUpView;

  ScreenTypeLayout({
    required this.smallMobile,
    required this.mediumMobile,
    required this.largeMobile,
    required this.smallTablet,
    required this.mediumTablet,
    required this.desktop,
    required this.iPhone8ToXSMax,
    required this.loginSignUpView
  });

  @override
  _ScreenTypeLayoutState createState() => _ScreenTypeLayoutState(this.loginSignUpView);
}

class _ScreenTypeLayoutState extends State<ScreenTypeLayout> {
  final bool loginSignUpView;

  _ScreenTypeLayoutState(this.loginSignUpView);

  @override
  Widget build(BuildContext context) {
    final drawerModel = Provider.of<DrawerModel>(context);

    return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.black12
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight
                  )
              ),
            ),
            Container(
              width: 200,
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Wolf",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          title: Text(
                            "Home",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          leading: Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                          onTap: () {

                          },
                        ),
                        ListTile(
                          title: Text(
                            "Profile",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          leading: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          onTap: () {

                          },
                        ),
                        ListTile(
                          title: Text(
                            "Settings",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          leading: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                          onTap: () {

                          },
                        ),
                        ListTile(
                          title: Text(
                            "Log out",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          leading: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          onTap: () {
                            context.read<AuthenticationService>().signOut();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: drawerModel.value),
              duration: Duration(milliseconds: 500),
              builder: (_, double val, __) {
                if(loginSignUpView) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..setEntry(0, 3, 200 * val)
                      ..rotateY((pi/6) * val),
                    child: SafeArea(
                      child: Scaffold(
                        body: ResponsiveBuilder(
                          builder: (context, sizingInformation) {
                            if(sizingInformation.deviceScreenType == DeviceScreenType.SmallMobile) {
                              if(widget.smallMobile != null) {
                                return widget.smallMobile;
                              }
                            }
                            if(sizingInformation.deviceScreenType == DeviceScreenType.MediumMobile) {
                              if(widget.mediumMobile != null) {
                                return widget.mediumMobile;
                              }
                            }
                            if(sizingInformation.deviceScreenType == DeviceScreenType.LargeMobile) {
                              if(widget.largeMobile != null) {
                                return widget.largeMobile;
                              }
                            }
                            if(sizingInformation.deviceScreenType == DeviceScreenType.SmallTablet) {
                              if(widget.smallTablet != null) {
                                return widget.smallTablet;
                              }
                            }
                            if(sizingInformation.deviceScreenType == DeviceScreenType.MediumTablet) {
                              if(widget.mediumTablet != null) {
                                return widget.mediumTablet;
                              }
                            }
                            if(sizingInformation.deviceScreenType == DeviceScreenType.Desktop) {
                              if(widget.desktop != null) {
                                return widget.desktop;
                              }
                            }
                            return widget.iPhone8ToXSMax;
                          },
                        ),
                      ),
                    ),
                  );
                }
                else {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..setEntry(0, 3, 200 * val)
                      ..rotateY((pi/6) * val),
                    child: SafeArea(
                      child: Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.black,
                          leading: IconButton(
                            icon: Icon(
                              Icons.dehaze,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                drawerModel.drawerToggle();
                              });
                            },
                          ),
                        ),
                        body: ResponsiveBuilder(
                          builder: (context, sizingInformation) {
                            if(sizingInformation.deviceScreenType == DeviceScreenType.SmallMobile) {
                              if(widget.smallMobile != null) {
                                return widget.smallMobile;
                              }
                            }
                            if(sizingInformation.deviceScreenType == DeviceScreenType.MediumMobile) {
                              if(widget.mediumMobile != null) {
                                return widget.mediumMobile;
                              }
                            }
                            if(sizingInformation.deviceScreenType == DeviceScreenType.LargeMobile) {
                              if(widget.largeMobile != null) {
                                return widget.largeMobile;
                              }
                            }
                            if(sizingInformation.deviceScreenType == DeviceScreenType.SmallTablet) {
                              if(widget.smallTablet != null) {
                                return widget.smallTablet;
                              }
                            }
                            if(sizingInformation.deviceScreenType == DeviceScreenType.MediumTablet) {
                              if(widget.mediumTablet != null) {
                                return widget.mediumTablet;
                              }
                            }
                            if(sizingInformation.deviceScreenType == DeviceScreenType.Desktop) {
                              if(widget.desktop != null) {
                                return widget.desktop;
                              }
                            }
                            return widget.iPhone8ToXSMax;
                          },
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        )
    );
  }
}
