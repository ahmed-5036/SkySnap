// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
import 'package:sky_snap/model/weather_data_daily.dart';

import 'weather_data_current.dart';
import 'weather_data_hourly.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;
  final WeatherDataDaily? daily;

  WeatherData([this.current, this.hourly, this.daily]);
  WeatherDataCurrent getCurrentWeather() => current!;
  WeatherDataHourly getHourlyWeather() => hourly!;
  WeatherDataDaily getDailyWeather() => daily!;
}
