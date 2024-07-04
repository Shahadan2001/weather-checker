import 'dart:developer';

import 'package:api_repository/api_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final UserRepository userRepository;
  HomeCubit(this.userRepository) : super(const HomeState()) {
    init();
  }

  ///init function to show recent searched city data which is saved in shared preferences
  init() async {
    emit(state.copyWith(
        recentWeatherResponse: await UserPreferences.getWeatherDetails()));
  }

  ///on searching city
  Future<void> onSearch() async {
    try {
      if (state.searchText.isNotEmpty) {
        if (state.status == FormzSubmissionStatus.inProgress) return;
        emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
        var result =
            await userRepository.getWeatherDetails(city: state.searchText);
        var status = RequestStatus.SUCCESS == result.status
            ? FormzSubmissionStatus.success
            : FormzSubmissionStatus.failure;
        emit(state.copyWith(
            status: status, msg: result.message, weatherResponse: result.body));
        if (result.body != null) {
          UserPreferences.saveWeatherDetails(
              cityName: state.weatherResponse!.cityName,
              tempC: state.weatherResponse!.currentTemperature,
              weatherIcon: state.weatherResponse!.weatherIcon);
        }
      } else {
        emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            msg: 'City name is required',
            weatherResponse: null));
      }
    } catch (e) {
      log('error : $e');
    }
  }

  ///to clear status
  void clearStatus() {
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  ///to clear message
  void clearMsg() {
    emit(state.copyWith(msg: ''));
  }

  /// on typing text field
  void onSearchTextFieldChanged(value) {
    emit(state.copyWith(searchText: value));
  }
}
