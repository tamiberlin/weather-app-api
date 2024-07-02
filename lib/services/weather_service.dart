import 'dart:convert';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  static const GEO_URL = 'http://api.openweathermap.org/geo/1.0/direct';

  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

 Future<List<String>> getCitySuggestions(String query) async {
    final respone = await http.get(Uri.parse('$GEO_URL?q=$query&limit=5&appid=$apiKey'));

    if (respone.statusCode == 200) {
      final List data = jsonDecode(respone.body);
      
      return data.map<String>((json) => ['name'] as String).toList();
    } else {
      throw Exception("Failed to fetch city suggestions");
    }
  }
}
