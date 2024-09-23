import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_snap/controller/global_controller.dart';
import 'package:sky_snap/utils/custom_colors.dart';
import 'package:sky_snap/widgets/comfort.dart';
import 'package:sky_snap/widgets/current_weather.dart';
import 'package:sky_snap/widgets/daily_weather.dart';
import 'package:sky_snap/widgets/header_widget.dart';
import 'package:sky_snap/widgets/hourly_weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Lottie.asset(
                        "assets/splash/lottie_loading.json",
                        height: 220,
                        width: 220,
                      ),
                      Container(
                          padding: EdgeInsets.only(bottom: 40),
                          child: LoadingAnimationWidget.waveDots(
                            color: Colors.grey[700]!,
                            size: 50.0,
                          )),
                    ],
                  ),
                )
              // ignore: avoid_unnecessary_containers
              : Container(
                  child: Center(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const HeaderWidget(),
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
