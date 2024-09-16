import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import '../controller/global_controller.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  RxString city = ''.obs;
  RxString date = ''.obs;

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  void initState() {
    getAddress(globalController.getLatitude().value,
        globalController.getLongitude().value);
    updateDate();
    super.initState();
  }

  void getAddress(latitude, longitude) async {
    try {
      List<Placemark> placemark =
          await placemarkFromCoordinates(latitude, longitude)
              .timeout(const Duration(seconds: 10)); // Increased timeout
      if (placemark.isNotEmpty) {
        Placemark place = placemark[0];
        city.value = place.locality ?? 'Unknown';
        //print(place);
      } else {
        city.value = 'Unknown';
      }
    } catch (e) {
      //print('Failed to get address: $e');
      city.value = 'Unknown';
    }
  }

  void updateDate() {
    date.value = DateFormat("yMMMMd").format(DateTime.now());
    //print(date);
    //print(date.value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            alignment: Alignment.topLeft,
            child: Obx(
              () => Text(
                city.value, // City name automatically updates here
                style: const TextStyle(fontSize: 34, height: 2),
              ),
            )),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            alignment: Alignment.topLeft,
            child: Obx(
              () => Text(
                date.value, // City name automatically updates here
                style:
                    TextStyle(fontSize: 14, color: Colors.grey[700], height: 2),
              ),
            )),
      ],
    );
  }
}
