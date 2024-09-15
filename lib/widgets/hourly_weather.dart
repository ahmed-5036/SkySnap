import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sky_snap/controller/global_controller.dart';

import 'package:sky_snap/model/weather_data_hourly.dart';
import 'package:sky_snap/utils/custom_colors.dart';

class HourlyWeatherWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  HourlyWeatherWidget({super.key, required this.weatherDataHourly});
  RxInt currentIndex = GlobalController().getIndex();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topCenter,
          child: Text(
            "Today",
            style: TextStyle(fontSize: 18),
          ),
        ),
        hourlyList()
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 160,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length > 14
            ? 14
            : weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx(() => GestureDetector(
              onTap: () {
                currentIndex.value = index;
              },
              child: Container(
                width: 90,
                margin: EdgeInsets.only(left: 12, right: 12),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: currentIndex.value == index
                          ? CustomColors.secondGradientColor.withAlpha(150)
                          : CustomColors.dividerLine.withAlpha(150),
                      width: 1, // Set the border width
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 20,
                        spreadRadius: 0,
                        color: CustomColors.dividerLine.withAlpha(120),
                      )
                    ],
                    gradient: currentIndex.value == index
                        ? CustomColors.linearGradient
                        : null),
                child: HourlyDetails(
                    index: index,
                    currentIndex: currentIndex.toInt(),
                    temp: weatherDataHourly.hourly[index].temp!,
                    timeStamp: weatherDataHourly.hourly[index].dt!,
                    weatherIcon:
                        weatherDataHourly.hourly[index].weather![0].icon!),
              )));
        },
      ),
    );
  }
}

class HourlyDetails extends StatelessWidget {
  int temp, timeStamp, index, currentIndex;
  String weatherIcon;
  HourlyDetails(
      {super.key,
      required this.index,
      required this.currentIndex,
      required this.temp,
      required this.timeStamp,
      required this.weatherIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              formatTimestamp(timeStamp),
              style: TextStyle(
                color: currentIndex == index ? Colors.white : Colors.black,
              ),
            )),
        Container(
          margin: EdgeInsets.all(5),
          child: Image.asset(
            "assets/weather/${weatherIcon}.png",
            width: 40,
            height: 40,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            "$temp°",
            style: TextStyle(
              color: currentIndex == index ? Colors.white : Colors.black,
            ),
          ),
        )
      ],
    );
  }

  String formatTimestamp(int timestamp) {
    // Convert timestamp (in seconds) to DateTime
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    // Format the DateTime object
    return DateFormat('jm').format(date); // Example: 2:30 PM
  }
}
