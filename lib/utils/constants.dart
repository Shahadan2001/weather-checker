import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/utils/utils.dart';

class Constants {
  /// text styles
  static TextStyle titleTextStyle = TextStyle(
      fontSize: 25.sp,
      color: CustomColor.pureBlack,
      fontWeight: FontWeight.w800);
  static TextStyle headTextStyle = TextStyle(
    fontSize: 30.sp,
    color: CustomColor.pureBlack,
    fontWeight: FontWeight.w800,
  );
  static TextStyle subheadTextStyle = TextStyle(
    fontSize: 23.sp,
    color: CustomColor.pureBlack.withOpacity(0.8),
    fontWeight: FontWeight.w800,
  );
  static TextStyle normalTextStyle = TextStyle(
    fontSize: 20.sp,
    color: CustomColor.pureBlack,
  );
  static TextStyle defaultTextStyle = TextStyle(
    fontSize: 16.sp,
    color: CustomColor.pureBlack,
  );
  static TextStyle hintTextStyle = TextStyle(
    fontSize: 15.sp,
    color: CustomColor.hintColor,
  );
}
