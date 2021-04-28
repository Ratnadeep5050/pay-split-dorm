import 'package:flutter/material.dart';
import 'package:pay_split/responsive_ui/SizingInformation.dart';
import '../uiUtils/UIUtility.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, SizingInformation sizingInformation) builder;

  const ResponsiveBuilder({required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, boxConstraints) {
          var mediaQuery = MediaQuery.of(context);
          var sizingInformation = new SizingInformation(
              deviceScreenType: getDeviceType(mediaQuery),
              screenSize: mediaQuery.size,
              localWidgetSize: Size(boxConstraints.maxWidth, boxConstraints.maxHeight)
          );
          return builder(context, sizingInformation);
        }
    );
  }
}
