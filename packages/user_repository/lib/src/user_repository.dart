import 'package:api_repository/api_repository.dart';
import 'package:user_repository/user_repository.dart';

class UserRepository {
  final ApiClient _apiClient;
  const UserRepository(this._apiClient);

  /// getting weather details
  Future<RequestStatus<WeatherResponse>> getWeatherDetails(
      {required String city}) async {
    return await _apiClient.getWeatherDetails(city: city);
  }

}
