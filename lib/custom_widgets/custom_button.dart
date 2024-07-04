import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/utils/utils.dart';

class CustomButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  const CustomButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(90.w, 38.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        backgroundColor: CustomColor.primaryColor,
      ),
      child: Text(
        text,
        style: Constants.defaultTextStyle,
      ),
    );
  }
}
