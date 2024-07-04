import 'package:api_repository/api_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:weather/cubits/home/home_cubit.dart';
import 'package:weather/custom_widgets/custom_button.dart';
import 'package:weather/utils/extensions/widget_extension.dart';
import 'package:weather/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class WeatherDetailScreen extends StatelessWidget {
  // final WeatherResponse weatherResponse;
  const WeatherDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ///getting arguments
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final WeatherResponse weatherResponse = arguments['weather_response'];
    final HomeCubit homeCubitValue = arguments['home_cubit'];

    ///current date
    var now = DateTime.now();
    var currentDate = DateFormat('dd-MM-yyyy').format(now);

    /// function to convert weak day into day
    String getDay(int day) {
      switch (day) {
        case 1:
          return "Monday";
        case 2:
          return "Tuesday";
        case 3:
          return "Wednesday";
        case 4:
          return "Thursday";
        case 5:
          return "Friday";
        case 6:
          return "Saturday";
        case 7:
          return "Sunday";
      }
      return '';
    }

    return BlocProvider.value(
      value: homeCubitValue,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var homeCubit = context.read<HomeCubit>();
          return Scaffold(
              backgroundColor: CustomColor.secondaryColor,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35.h,
                  ),
                  BackButton(onPressed: () {
                    homeCubit.init();
                    Navigator.pop(context);
                  }),
                  Column(
                    children: [
                      Container(
                        height: 300.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: CustomColor.lightColor.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: state.status == FormzSubmissionStatus.inProgress
                            ? const CircularProgressIndicator(
                                color: CustomColor.primaryColor,
                              ).wrapCenter()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 160.w,
                                        child: Text(
                                          weatherResponse.cityName,
                                          style: Constants.headTextStyle,
                                        ),
                                      ),
                                      Text(
                                        getDay(now.weekday),
                                        style: Constants.subheadTextStyle,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    currentDate.toString(),
                                    style: Constants.defaultTextStyle,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl:
                                                'http:${weatherResponse.weatherIcon}',
                                          ),
                                          Text(
                                            weatherResponse.weatherCondition ??
                                                '',
                                            style: Constants.defaultTextStyle,
                                          )
                                        ],
                                      ),
                                      Text(
                                        '${weatherResponse.currentTemperature}°C',
                                        style: Constants.titleTextStyle,
                                      ),
                                    ],
                                  ).paddingSymmetric(
                                      horizontal: 22.w, vertical: 10.h),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Humidity: ${weatherResponse.humidityPercentage}%',
                                          style: Constants.titleTextStyle),
                                      Text(
                                        'Wind speed: ${weatherResponse.windSpeed}kph',
                                        style: Constants.titleTextStyle,
                                      ),
                                    ],
                                  ).wrapCenter().paddingOnly(top: 15.h)
                                ],
                              ).paddingSymmetric(
                                horizontal: 22.w, vertical: 10.h),
                      ).paddingOnly(top: 25.w),

                      ///refresh button
                      CustomButton(
                              onTap: () => homeCubit.onSearch(),
                              text: 'Refresh')
                          .paddingOnly(top: 25.h),
                    ],
                  ).paddingSymmetric(
                    horizontal: 22.w,
                  )
                ],
              ));
        },
      ),
    );
  }
}
