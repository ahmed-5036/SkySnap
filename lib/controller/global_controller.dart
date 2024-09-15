import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sky_snap/api/fetch_weather.dart';
import 'package:sky_snap/model/weather_Data.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;

  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;

  RxInt _currentIndex = 0.obs;

  final Rx<WeatherData> weatherData = WeatherData().obs;
  WeatherData getWeatherData() {
    return weatherData.value;
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      LoadLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  LoadLocation() async {
    bool serviceEnabled;
    LocationPermission locationPermission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) Future.error("Location is disabled");

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission is denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      //return Future.error("Location permission is denied");
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied)
        return Future.error("Location permission is denied");
    }
    //accuracy = await Geolocator.getLocationAccuracy();
    return await Geolocator.getCurrentPosition(
            locationSettings: LocationSettings(accuracy: LocationAccuracy.high))
        .then((value) {
      _longitude.value = value.longitude;
      _latitude.value = value.latitude;
      //calling weather api
      return FetchWeatherAPI()
          .processData(value.latitude, value.longitude)
          .then((value) {
        weatherData.value = value!;

        _isLoading.value = false;
      });
    });
  }

  RxInt getIndex() {
    return _currentIndex;
  }
}
