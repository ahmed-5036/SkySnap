import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sky_snap/model/weather_data_daily.dart';
import 'package:sky_snap/utils/custom_colors.dart';

class DailyWeatherWidget extends StatefulWidget {
  final WeatherDataDaily weatherDataDaily;

  const DailyWeatherWidget({
    super.key,
    required this.weatherDataDaily,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DailyWeatherWidgetState createState() => _DailyWeatherWidgetState();
}

class _DailyWeatherWidgetState extends State<DailyWeatherWidget> {
  int? selectedIndex; // Track the selected index

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = null; // Deselect if tapping outside
        });
      },
      child: Container(
        height: 400,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: CustomColors.dividerLine.withAlpha(150),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: const Text(
                "Next Days",
                style: TextStyle(
                  color: CustomColors.textColorBlack,
                  fontSize: 17,
                ),
              ),
            ),
            dailyList(),
          ],
        ),
      ),
    );
  }

  Widget dailyList() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.weatherDataDaily.daily.length > 7
            ? 7
            : widget.weatherDataDaily.daily.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                if (selectedIndex == index) {
                  selectedIndex = null; // Deselect if the same item is tapped
                } else {
                  selectedIndex = index; // Select the tapped item
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected
                      ? CustomColors.secondGradientColor.withAlpha(150)
                      : CustomColors.dividerLine.withAlpha(150),
                  width: 1, // Set the border width
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    blurRadius: 20,
                    spreadRadius: 0,
                    color: CustomColors.dividerLine.withAlpha(120),
                  )
                ],
                gradient: isSelected ? CustomColors.linearGradient : null,
              ),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(
                          formatDay(widget.weatherDataDaily.daily[index].dt!),
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                          "assets/weather/${widget.weatherDataDaily.daily[index].weather![0].icon}.png",
                        ),
                      ),
                      Text(
                        "${widget.weatherDataDaily.daily[index].temp!.min}°/${widget.weatherDataDaily.daily[index].temp!.max}°",
                        style: TextStyle(
                          fontSize: 13,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      constraints: BoxConstraints(
                        maxHeight: isSelected ? double.infinity : 0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                widget.weatherDataDaily.daily[index].summary!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2, // Limit the number of lines
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String formatDay(int day) {
    var date = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    return DateFormat('EEE').format(date); // Example: 2:30 PM
  }
}
