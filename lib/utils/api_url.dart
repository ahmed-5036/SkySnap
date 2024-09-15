import 'package:sky_snap/api/api_key.dart';

String apiURL(var latitude, var longitude) {
  String url;
  url =
      'https://api.openweathermap.org/data/3.0/onecall?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&exclude=minutely';
  return url;
}
