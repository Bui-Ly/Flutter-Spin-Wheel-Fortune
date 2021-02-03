import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spin_wheel_app/page/test/test_controller.dart';
import 'package:get/get.dart';

class TestAnimatedPostition extends StatelessWidget {
  var c = Get.find<TestController>(tag: '/test');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Stack(
        children: [
          for (int i = 1; i <= 5; i++)
            Obx(() {
              int min = 50;
              int max = 100;
              var ran = Random();
              var r = min + ran.nextInt(max - min);
              var r2 = ran.nextInt(100);
              if (c.pos.value == 500) {
                return Container();
              }

              print('random: ${r.toDouble()}');

              return AnimatedPositioned(
                top: c.pos.value + i * 20 ,
                right: r.toDouble() + 60*i,
                duration: Duration(seconds: 1),
                child: Container(
                  child: Image.asset('assets/hoamai.png', width: 30, height: 30),
                ),
              );
            }),
        ],
      ),
    );
  }
}
