import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import '../enums/DeviceScreenType.dart';

DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.shortestSide;
  //print(deviceWidth);

  if(deviceWidth > 800) {
    return DeviceScreenType.Desktop;
  }
  else if(deviceWidth > 600) {
    return DeviceScreenType.MediumTablet;
  }
  else if(deviceWidth > 480) {
    return DeviceScreenType.SmallTablet;
  }
  else if(deviceWidth > 360) {
    if(deviceWidth >= 375 && deviceWidth <= 414) {
      return DeviceScreenType.iPhone8ToXSMax;
    }
    return DeviceScreenType.LargeMobile;
  }
  else if(deviceWidth > 320) {
    return DeviceScreenType.MediumMobile;
  }
  else {
    return DeviceScreenType.SmallMobile;
  }

}