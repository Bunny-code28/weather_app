import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'data/models/weather_model.dart';

class WeatherRepository {
  static final _apiKey = dotenv.env['OPENWEATHER_API_KEY'];
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherModel> getWeatherByCity(String city) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?q=$city&units=metric&appid=$_apiKey'),
      );

      if (response.statusCode == 200) { // Correct status code check
        return WeatherModel.fromJson(json.decode(response.body)); // Correct parsing
      } else {
        throw Exception('Failed to fetch weather: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather: $e');
    }
  }

  Future<WeatherModel> getWeatherByLocation(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?lat=$lat&lon=$lon&units=metric&appid=$_apiKey'),
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to fetch weather: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather: $e');
    }
  }
}