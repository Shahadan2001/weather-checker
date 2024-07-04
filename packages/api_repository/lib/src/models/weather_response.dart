class WeatherResponse {
  final String cityName;
  final double currentTemperature;
  final String? weatherCondition;
  final String weatherIcon;
  final int? humidityPercentage;
  final double? windSpeed;
  const WeatherResponse({
    required this.cityName,
    required this.currentTemperature,
    required this.weatherIcon,
    this.humidityPercentage,
    this.weatherCondition,
    this.windSpeed,
  });
  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      WeatherResponse(
        cityName: json['location']['name'],
        currentTemperature: json['current']['temp_c'],
        weatherIcon: json['current']['condition']['icon'],
        humidityPercentage: json['current']['humidity'],
        weatherCondition: json['current']['condition']['text'],
        windSpeed: json['current']['wind_kph'],
      );
}
