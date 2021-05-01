import 'package:flutter/cupertino.dart';

class DrawerModel {
  double value = 0;

  drawerToggle() {
    if(value == 0) {
      value = 1;
    }
    else {
      value = 0;
    }
  }
}