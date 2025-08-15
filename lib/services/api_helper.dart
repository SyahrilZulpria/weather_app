import 'package:dio/dio.dart';
import 'package:weather_app/models/hourly_weather.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/models/weekly_weather.dart';
import 'package:weather_app/services/geolocator.dart';

import '/constants/constants.dart';
import '/util/logging.dart';

class ApiHelper {
  static const baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const weeklyWeatherUrl =
      'https://api.open-meteo.com/v1/forecast?current=&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto';

  static double lat = 0.0;
  static double lon = 0.0;
  static final dio = Dio();

  // Hourly Forecast by City
  static Future<HourlyWeather> getHourlyForecastByCity(String cityName) async {
    final url =
        '$baseUrl/forecast?q=$cityName&units=metric&appid=${Constants.apiKey}';
    final response = await _fetchData(url);
    return HourlyWeather.fromJson(response);
  }

  // Weekly Forecast by City (OpenMeteo API tidak pakai city, butuh lat/lon dari geocoding)
  static Future<WeeklyWeather> getWeeklyForecastByCity(String cityName) async {
    // Ambil lat/lon dari nama kota
    final geoUrl =
        'http://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=1&appid=${Constants.apiKey}';
    final geoData = await _fetchData(geoUrl);

    if (geoData is List && geoData.isNotEmpty) {
      final lat = geoData[0]['lat'];
      final lon = geoData[0]['lon'];
      final url =
          'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&hourly=temperature_2m';
      final response = await _fetchData(url);
      return WeeklyWeather.fromJson(response);
    } else {
      throw Exception('Kota tidak ditemukan');
    }
  }

  //Get Latitude and Longitude
  static Future<void> fetchLocation() async {
    final location = await getLocation();
    lat = location.latitude;
    lon = location.longitude;
  }

  // Current Weather
  static Future<Weather> getCurrentWeather() async {
    await fetchLocation();
    final url = _constructWeatherUrl();
    final response = await _fetchData(url);
    return Weather.fromJson(response);
  }

  // Hourly Forecast
  static Future<HourlyWeather> getHourlyForecast() async {
    await fetchLocation();
    final url = _constructForecastUrl();
    final response = await _fetchData(url);
    return HourlyWeather.fromJson(response);
  }

  // Weekly weather
  static Future<WeeklyWeather> getWeeklyForecast() async {
    await fetchLocation();
    final url = _constructWeeklyForecastUrl();
    final response = await _fetchData(url);
    return WeeklyWeather.fromJson(response);
  }

  //* Weather by City Name
  static Future<Weather> getWeatherByCityName({
    required String cityName,
  }) async {
    final url = _constructWeatherByCityUrl(cityName);
    final response = await _fetchData(url);
    return Weather.fromJson(response);
  }

  //Build the URL for weather
  static String _constructWeatherUrl() =>
      '$baseUrl/weather?lat=$lat&lon=$lon&units=metric&appid=${Constants.apiKey}';

  static String _constructForecastUrl() =>
      '$baseUrl/forecast?lat=$lat&lon=$lon&units=metric&appid=${Constants.apiKey}';

  static String _constructWeatherByCityUrl(String cityName) =>
      '$baseUrl/weather?q=$cityName&units=metric&appid=${Constants.apiKey}';

  static String _constructWeeklyForecastUrl() =>
      '$weeklyWeatherUrl&latitude=$lat&longitude=$lon';

  //Fetch data
  static Future<Map<String, dynamic>> _fetchData(String url) async {
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        printWarning('Failed to fetch data: ${response.statusCode}');
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      printWarning('Error fetching data from: $url: $e');
      throw Exception('Failed to fetch data');
    }
  }
}
