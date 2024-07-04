import 'package:flutter/material.dart';
import 'package:weather/utils/utils.dart';

PreferredSizeWidget customAppbar() => AppBar(
      title: Text(
        'Weather Checker',
        style: Constants.titleTextStyle,
      ),
      centerTitle: true,
      backgroundColor: CustomColor.primaryColor,
      elevation: 0,
    );
