import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/utils/utils.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Constants.defaultTextStyle,
      decoration: InputDecoration(
          hintText: 'Search city',
          hintStyle: Constants.hintTextStyle,
          fillColor: CustomColor.lightColor,
          filled: true,
          border: InputBorder.none,
          isDense: true,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide:
                  BorderSide(color: CustomColor.lightColor, width: 0.5.w)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide:
                  BorderSide(color: CustomColor.lightColor, width: 0.5.w))),
    );
  }
}

///CustomSearchField in bloc state management
class CustomSearchFieldBloc<B extends StateStreamable<S>, S>
    extends StatelessWidget {
  final void Function(String, B) onChanged;
  const CustomSearchFieldBloc({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      builder: (context, state) {
        return TextField(
          style: Constants.defaultTextStyle,
          decoration: InputDecoration(
              hintText: 'Search city',
              hintStyle: Constants.hintTextStyle,
              fillColor: CustomColor.lightColor,
              filled: true,
              border: InputBorder.none,
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide:
                      BorderSide(color: CustomColor.lightColor, width: 0.5.w)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide:
                      BorderSide(color: CustomColor.lightColor, width: 0.5.w))),
          onChanged: (value) => onChanged(value, context.read<B>()),
        );
      },
    );
  }
}
