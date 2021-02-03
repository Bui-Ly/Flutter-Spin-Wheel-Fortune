import 'package:flutter/material.dart';
import 'package:flutter_spin_wheel_app/page/home/home_binding.dart';
import 'package:flutter_spin_wheel_app/page/home/home_page.dart';
import 'package:flutter_spin_wheel_app/page/test/test_animated_postition_page.dart';
import 'package:flutter_spin_wheel_app/page/test/test_binding.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/test',
          page: () => TestAnimatedPostition(),
          binding: TestBinding(),
        ),
      ],
      initialRoute: '/',
    );
  }
}
