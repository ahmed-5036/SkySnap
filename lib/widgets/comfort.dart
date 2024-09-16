import 'package:flutter/material.dart';
import 'package:sky_snap/model/weather_data_current.dart';
import 'package:sky_snap/utils/custom_colors.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ComfortWidget extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;
  const ComfortWidget({super.key, required this.weatherDataCurrent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin:
              const EdgeInsets.only(top: 1, left: 20, right: 20, bottom: 20),
          child: const Text(
            "Comfort Level",
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(
          height: 180,
          child: Column(
            children: [
              Center(
                child: SleekCircularSlider(
                    min: 0,
                    max: 100,
                    initialValue:
                        weatherDataCurrent.current.humidity!.toDouble(),
                    appearance: CircularSliderAppearance(
                        customWidths: CustomSliderWidths(
                            trackWidth: 14,
                            handlerSize: 0,
                            progressBarWidth: 14),
                        infoProperties: InfoProperties(
                            bottomLabelText: "Humidity",
                            bottomLabelStyle: const TextStyle(
                                letterSpacing: 0.1, fontSize: 14, height: 1.5)),
                        animationEnabled: true,
                        size: 140,
                        customColors: CustomSliderColors(
                            hideShadow: true,
                            trackColor:
                                CustomColors.firstGradientColor.withAlpha(100),
                            progressBarColors: [
                              CustomColors.firstGradientColor,
                              CustomColors.secondGradientColor
                            ])),
                    onChange: (double value) {
                      //print(value);
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                      text: "Feels like ",
                      style: TextStyle(
                          fontSize: 14,
                          height: 0.8,
                          color: CustomColors.textColorBlack,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: "${weatherDataCurrent.current.feelsLike}°",
                      style: const TextStyle(
                          fontSize: 14,
                          height: 0.8,
                          color: CustomColors.textColorBlack,
                          fontWeight: FontWeight.w400),
                    ),
                  ]))
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
