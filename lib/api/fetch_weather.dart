import 'dart:convert';

import 'package:sky_snap/model/weather_data_daily.dart';
import 'package:sky_snap/model/weather_data_hourly.dart';
import 'package:sky_snap/utils/api_url.dart';

import 'package:sky_snap/model/weather_Data.dart';
import 'package:http/http.dart' as http;

import '../model/weather_data_current.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;
  Future<WeatherData?> processData(latitude, longitude) async {
    var response = await http.get(Uri.parse(apiURL(latitude, longitude)));
    var jsonString = jsonDecode(response.body);
    //print(jsonString);
    weatherData = WeatherData(
        WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString),
        WeatherDataDaily.fromJson(jsonString));
    //print(weatherData!);
    return weatherData!;
  }
}
