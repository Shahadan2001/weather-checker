import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'models/models.dart';

class ApiClient {
  final http.Client _httpClient;
  ApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final String baseUrl = 'api.weatherapi.com';

  ///common catch block
  RequestStatus<T> _commonCatchBlock<T>(e, StackTrace stackTrace) {
    log('Catch Error: $stackTrace'); //printing error
    if (e is TimeoutException || e is SocketException) {
      return const RequestStatus(
          RequestStatus.FAILURE, 'Check internet connection', null);
    }
    return const RequestStatus(
        RequestStatus.FAILURE, 'Something went wrong', null);
  }

  ///fetching weather details of a city
  Future<RequestStatus<WeatherResponse>> getWeatherDetails(
      {required String city}) async {
    try {
      var fetchWeatherDetailUrl = Uri.http(baseUrl, 'v1/current.json',
          {"key": "ab29e5accaee429983472632240307", "aqi": "no", "q": city});
      var response = await _httpClient.get(fetchWeatherDetailUrl);
      log('-----weather details response-----\n${response.body}');
      print(response.statusCode);
      if (response.statusCode == 200) {
        WeatherResponse result =
            WeatherResponse.fromJson(jsonDecode(response.body));
        return RequestStatus(RequestStatus.SUCCESS, 'Success', result);
      } else {
        return RequestStatus(RequestStatus.FAILURE,
            jsonDecode(response.body)['error']['message'], null);
      }
    } catch (e, stackTrace) {
      return _commonCatchBlock(e, stackTrace);
    }
  }
}
