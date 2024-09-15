import 'package:sky_snap/model/weather/feels_like.dart';
import 'package:sky_snap/model/weather/temp.dart';

import 'weather/weather.dart';

class WeatherDataDaily {
  List<Daily> daily;
  WeatherDataDaily({required this.daily});

  factory WeatherDataDaily.fromJson(Map<String, dynamic> json) =>
      WeatherDataDaily(
          daily: List<Daily>.from(json['daily'].map((e) => Daily.fromJson(e))));
}

class Daily {
  int? dt;

  String? summary;
  Temp? temp;
  FeelsLike? feelsLike;
  int? pressure;
  int? humidity;
  double? dewPoint;
  double? windSpeed;
  int? windDeg;
  double? windGust;
  List<Weather>? weather;
  int? clouds;
  double? pop;
  double? uvi;
  double? rain;

  Daily({
    this.dt,
    this.summary,
    this.temp,
    this.feelsLike,
    this.humidity,
    this.weather,
    this.clouds,
    this.rain,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json['dt'] as int?,
        summary: json['summary'] as String?,
        temp: json['temp'] == null
            ? null
            : Temp.fromJson(json['temp'] as Map<String, dynamic>),
        feelsLike: json['feels_like'] == null
            ? null
            : FeelsLike.fromJson(json['feels_like'] as Map<String, dynamic>),
        humidity: json['humidity'] as int?,
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
        clouds: json['clouds'] as int?,
        rain: (json['rain'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'summary': summary,
        'temp': temp?.toJson(),
        'feels_like': feelsLike?.toJson(),
        'humidity': humidity,
        'weather': weather?.map((e) => e.toJson()).toList(),
        'clouds': clouds,
        'rain': rain,
      };
}
