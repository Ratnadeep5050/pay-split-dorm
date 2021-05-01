import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pay_split/RouteGenerator.dart';
import 'package:pay_split/viewmodels/DrawerModel.dart';
import 'package:pay_split/viewmodels/GroupsListViewModel.dart';
import 'package:pay_split/viewmodels/ItemsListViewModel.dart';
import 'package:pay_split/views/HomeView.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<GroupsListViewModel>(create: (_) => GroupsListViewModel()),
        Provider<ItemsListViewModel>(create: (_) => ItemsListViewModel()),
        Provider<DrawerModel>(create: (_) => DrawerModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView()
    );
  }
}

