part of 'home_cubit.dart';

class HomeState {
  final FormzSubmissionStatus status;
  final String msg;
  final String searchText;
  final WeatherResponse? weatherResponse;
  final WeatherResponse? recentWeatherResponse;
  const HomeState(
      {this.status = FormzSubmissionStatus.initial,
      this.msg = '',
      this.weatherResponse,
      this.recentWeatherResponse,
      this.searchText = ''});
  List<Object?> get props =>
      [status, msg, weatherResponse, searchText, recentWeatherResponse];

  /// copy with function
  HomeState copyWith(
          {FormzSubmissionStatus? status,
          String? msg,
          WeatherResponse? weatherResponse,
          String? searchText,
          WeatherResponse? recentWeatherResponse}) =>
      HomeState(
        msg: msg ?? this.msg,
        status: status ?? this.status,
        weatherResponse: weatherResponse ?? this.weatherResponse,
        searchText: searchText ?? this.searchText,
        recentWeatherResponse:
            recentWeatherResponse ?? this.recentWeatherResponse,
      );
}
