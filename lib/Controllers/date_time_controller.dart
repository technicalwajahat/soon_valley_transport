import 'dart:async';

import 'package:get/get.dart';

class DateTimeController extends GetxController {
  Rx<DateTime> now = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (now.value != DateTime.now()) {
        now.value = DateTime.now();
      }
    });
  }
}
