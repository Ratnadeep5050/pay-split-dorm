import 'package:flutter/cupertino.dart';
import '../enums/DeviceScreenType.dart';

class SizingInformation {
  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size localWidgetSize;

  SizingInformation({
    required this.deviceScreenType,
    required this.screenSize,
    required this.localWidgetSize
  });

  @override
  String toString() {
    return 'DeviceScreenType:$deviceScreenType, ScreenSize:$screenSize, LocalWidgetSize:$localWidgetSize';
  }
}