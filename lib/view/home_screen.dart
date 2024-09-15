import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_snap/controller/global_controller.dart';
import 'package:sky_snap/utils/custom_colors.dart';
import 'package:sky_snap/widgets/comfort.dart';
import 'package:sky_snap/widgets/current_weather.dart';
import 'package:sky_snap/widgets/daily_weather.dart';
import 'package:sky_snap/widgets/header_widget.dart';
import 'package:sky_snap/widgets/hourly_weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Obx(() => globalController.checkLoading().isTrue
              ? Center(
                  child: Image.asset(
                    "assets/icons/clouds.png",
                    height: 60,
                    width: 60,
                  ),
                )
              : Container(
                  child: Center(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        HeaderWidget(),
                        CurrentWeatherWidget(
                          weatherDataCurrent: globalController
                              .getWeatherData()
                              .getCurrentWeather(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        HourlyWeatherWidget(
                            weatherDataHourly: globalController
                                .getWeatherData()
                                .getHourlyWeather()),
                        DailyWeatherWidget(
                            weatherDataDaily: globalController
                                .getWeatherData()
                                .getDailyWeather()),
                        Container(
                          height: 1,
                          color: CustomColors.dividerLine,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ComfortWidget(
                            weatherDataCurrent: globalController
                                .getWeatherData()
                                .getCurrentWeather())
                      ],
                    ),
                  ),
                ))),
    );
  }
}
