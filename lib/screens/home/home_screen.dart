import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';
import 'package:weather/cubits/home/home_cubit.dart';
import 'package:weather/custom_widgets/custom_appbar.dart';
import 'package:weather/custom_widgets/custom_button.dart';
import 'package:weather/custom_widgets/custom_searchfield.dart';
import 'package:weather/screens/screens.dart';
import 'package:weather/utils/extensions/widget_extension.dart';
import 'package:weather/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(context.read<UserRepository>()),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          var homeCubit = context.read<HomeCubit>();
          if (state.status == FormzSubmissionStatus.success) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/weather-details',
              (Route<dynamic> route) => route.settings.name == '/',
              arguments: {
                'weather_response': state.weatherResponse,
                'home_cubit': homeCubit
              },
            );
            homeCubit.clearStatus();
            homeCubit.clearMsg();
          } else if (state.status == FormzSubmissionStatus.failure) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.msg)));
            homeCubit.clearStatus();
            homeCubit.clearMsg();
          }
        },
        builder: (context, state) {
          var homeCubit = context.read<HomeCubit>();
          return Stack(
            children: [
              Opacity(
                opacity:
                    state.status == FormzSubmissionStatus.inProgress ? 0.4 : 1,
                child: Scaffold(
                  backgroundColor: CustomColor.secondaryColor,
                  appBar: customAppbar(),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomSearchFieldBloc<HomeCubit, HomeState>(
                                    onChanged: (value, cubit) =>
                                        cubit.onSearchTextFieldChanged(value))
                                .paddingOnly(right: 10.w)
                                .expand(flex: 1),
                            CustomButton(
                                text: 'Search',
                                onTap: () => homeCubit.onSearch())
                          ],
                        ).paddingOnly(bottom: 25.h),
                        Text(
                          "‵Welcome to Weather Checker!\nDiscover the weather in any city at your fingertips.’",
                          style: Constants.subheadTextStyle,
                        ).paddingSymmetric(horizontal: 10.w),
                        if (state.recentWeatherResponse != null &&
                            state.recentWeatherResponse!.cityName.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recent searched city ',
                                style: Constants.titleTextStyle,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color:
                                        CustomColor.lightColor.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      state.recentWeatherResponse!.cityName,
                                      style: Constants.normalTextStyle,
                                    ),
                                    Text(
                                      '${state.recentWeatherResponse!.currentTemperature}℃',
                                      style: Constants.normalTextStyle,
                                    )
                                  ],
                                ).paddingSymmetric(
                                    horizontal: 10.w, vertical: 5.h),
                              ).paddingOnly(top: 10.h)
                            ],
                          ).paddingOnly(top: 25.w)
                      ],
                    ).paddingSymmetric(horizontal: 16.w, vertical: 12.h),
                  ),
                ),
              ),

              /// loading indicator
              if (state.status == FormzSubmissionStatus.inProgress)
                const CircularProgressIndicator(
                  color: CustomColor.primaryColor,
                ).wrapCenter()
            ],
          );
        },
      ),
    );
  }
}
