import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );
  Widget paddingOnly(
          {double top = 0,
          double left = 0,
          double right = 0,
          double bottom = 0}) =>
      Padding(
        padding:
            EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        child: this,
      );
  Widget expand({required int flex}) => Expanded(flex: flex, child: this);
  Widget asStaticButton({void Function()? onTap}) => GestureDetector(
        onTap: onTap,
        child: this,
      );
  Widget wrapCenter() => Center(child: this);
}
