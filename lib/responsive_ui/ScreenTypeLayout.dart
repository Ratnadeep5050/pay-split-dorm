import 'package:flutter/material.dart';
import 'package:pay_split/responsive_ui/ResponsiveBuilder.dart';
import '../enums/DeviceScreenType.dart';

class ScreenTypeLayout extends StatelessWidget {
  final Widget smallMobile;
  final Widget mediumMobile;
  final Widget largeMobile;
  final Widget smallTablet;
  final Widget mediumTablet;
  final Widget desktop;
  final Widget iPhone8ToXSMax;

  ScreenTypeLayout({
    required this.smallMobile,
    required this.mediumMobile,
    required this.largeMobile,
    required this.smallTablet,
    required this.mediumTablet,
    required this.desktop,
    required this.iPhone8ToXSMax
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if(sizingInformation.deviceScreenType == DeviceScreenType.SmallMobile) {
          if(smallMobile != null) {
            return smallMobile;
          }
        }
        if(sizingInformation.deviceScreenType == DeviceScreenType.MediumMobile) {
          if(mediumMobile != null) {
            return mediumMobile;
          }
        }
        if(sizingInformation.deviceScreenType == DeviceScreenType.LargeMobile) {
          if(largeMobile != null) {
            return largeMobile;
          }
        }
        if(sizingInformation.deviceScreenType == DeviceScreenType.SmallTablet) {
          if(smallTablet != null) {
            return smallTablet;
          }
        }
        if(sizingInformation.deviceScreenType == DeviceScreenType.MediumTablet) {
          if(mediumTablet != null) {
            return mediumTablet;
          }
        }
        if(sizingInformation.deviceScreenType == DeviceScreenType.Desktop) {
          if(desktop != null) {
            return desktop;
          }
        }
        return iPhone8ToXSMax;
      },
    );
  }
}
