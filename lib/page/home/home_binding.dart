import 'package:flutter_spin_wheel_app/page/home/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController(), tag: '/');

  }
  
}
