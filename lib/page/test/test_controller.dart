import 'dart:async';

import 'package:get/get.dart';

class TestController extends GetxController {

  var pos = 50.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    start();
    super.onInit();
  }


  void start() {
    Timer.periodic(Duration(milliseconds: 300), (timer) {
      if (pos.value == 500) {
        pos.value = 0.0;
      }
      pos.value += 10.0;
    });
  }

}
