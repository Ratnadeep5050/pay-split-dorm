import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pay_split/RouteGenerator.dart';
import 'package:pay_split/viewmodels/AuthenticationViewModel.dart';
import 'package:pay_split/viewmodels/DrawerModel.dart';
import 'package:pay_split/viewmodels/GroupsListViewModel.dart';
import 'package:pay_split/viewmodels/ItemsListViewModel.dart';
import 'package:pay_split/views/HomeView.dart';
import 'package:pay_split/views/LoginView.dart';
import 'package:provider/provider.dart';
import 'services/AuthenticationService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GroupsListViewModel>(create: (_) => GroupsListViewModel()),
        Provider<ItemsListViewModel>(create: (_) => ItemsListViewModel()),
        Provider<DrawerModel>(create: (_) => DrawerModel()),
        ChangeNotifierProvider<AuthenticationViewModel>(create: (_) => AuthenticationViewModel()),
        StreamProvider(create: (context) => context.read<AuthenticationService>().authStateChange, initialData: 0,)
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.generateRoute,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LoginView()
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    if(user != null) {
      return HomeView();
    }
    else {
      return LoginView();
    }
  }
}

