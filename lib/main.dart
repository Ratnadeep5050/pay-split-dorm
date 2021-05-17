import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pay_split/RouteGenerator.dart';
import 'package:pay_split/services/CloudFirebaseService.dart';
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
  late User user;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GroupsListViewModel>(
            create: (_) => GroupsListViewModel()
        ),
        Provider<CloudFirebaseService>(
            create: (_) => CloudFirebaseService()
        ),
        Provider<ItemsListViewModel>(
            create: (_) => ItemsListViewModel()
        ),
        Provider<DrawerModel>(
            create: (_) => DrawerModel()
        ),
        ChangeNotifierProvider<AuthenticationViewModel>(
            create: (_) => AuthenticationViewModel()
        ),
        Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance)
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.generateRoute,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: AuthenticationWrapper()
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.active) {
          if(snapshot.hasData) {
            User user = FirebaseAuth.instance.currentUser!;
            final uid = user.uid;
            context.read<CloudFirebaseService>().userModel.uid = uid;
            return HomeView();
          }
          else {
            print(snapshot.data);
            return LoginView();
          }
        }
        else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

