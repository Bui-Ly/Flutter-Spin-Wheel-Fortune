import 'package:flutter_spin_wheel_app/page/test/test_controller.dart';
import 'package:get/get.dart';

class TestBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TestController>(TestController(), tag: '/test');
  }

}
