import 'package:shared_preferences/shared_preferences.dart';
import 'package:api_repository/api_repository.dart';

class UserPreferences {

  ///to save data to shared preference
  static Future<void> saveWeatherDetails(
      {required String cityName,
      required double tempC,
      required String weatherIcon}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('city_name', cityName);
    await prefs.setDouble('temp_c', tempC);
    await prefs.setString('weather_icon', weatherIcon);
  }

  ///to get data from shared preference
  static Future<WeatherResponse> getWeatherDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String cityName = prefs.getString('city_name') ?? '';
    final double tempC = prefs.getDouble('temp_c') ?? 0.0;
    final String weatherIcon = prefs.getString('weather_icon') ?? '';
    return WeatherResponse(
        cityName: cityName,
        currentTemperature: tempC,
        weatherIcon: weatherIcon);
  }
}
