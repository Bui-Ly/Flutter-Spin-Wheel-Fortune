import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spin_wheel_app/page/home/home_controller.dart';
import 'package:flutter_spin_wheel_app/view/board_view.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final homeController = Get.find<HomeController>(tag: '/');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/tet.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: AnimatedBuilder(
              animation: homeController.ani.value,
              builder: (_, __) {
                return Obx(() {
                  final _value = homeController.ani.value.value;
                  final _angle = _value * homeController.angle.value * 1;

                  return Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      BoardView(
                        items: homeController.items,
                        current: homeController.current.value,
                        angle: _angle,
                      ),
                      _buildGo(context),
                    ],
                  );
                });
              },
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: Image.asset(
              'assets/xuan.png',
              width: 80,
              height: 80,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/right-hoamai.png',
              width: 150,
              height: 120,
            ),
          ),
          Positioned(
            top: 195,
            left: 80,
            child: Image.asset('assets/hoamai.png'),
          ),
          Positioned(
            top: 195,
            right: 80,
            child: Image.asset('assets/hoamai.png'),
          ),
          Positioned(
            top: 90,
            left: 20,
            child: Image.asset(
              'assets/vqmm.jpg',
              width: MediaQuery.of(context).size.width - 40,
              height: 150,
            ),
          ),
          for (int i = 1; i < 3; i++)
            Obx(() {
              int min = -40;
              int max = 0;
              var ran = Random();
              var r = min + ran.nextInt(max - min);

              if (homeController.pos.value > 900) {
                return Container();
              }

              return AnimatedPositioned(
                duration: Duration(seconds: 1),
                top: homeController.pos.value + Random().nextInt(3) * i,
                left: r.toDouble() + 50 * i + Random().nextInt(3) * 20,
                child: Container(
                  child: Image.asset('assets/hoamai.png', width: 30, height: 30),
                ),
              );
            }),
          for (int i = 1; i < 4; i++)
            Obx(() {
              int min = 0;
              int max = 40;
              var ran = Random();
              var r = min + ran.nextInt(max - min);

              if (homeController.pos.value > 900) {
                return Container();
              }

              return AnimatedPositioned(
                duration: Duration(seconds: 1),
                top: homeController.pos.value + Random().nextInt(3) * i * Random().nextInt(4),
                right: r.toDouble() + 40 * i + Random().nextInt(3) * 20,
                child: Container(
                  child: Image.asset('assets/hoamai.png', width: 30, height: 30),
                ),
              );
            }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/bottom.png'),
          ),
        ],
      ),
    );
  }

  // -func:
  _buildGo(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: CircleBorder(),
      child: InkWell(
        customBorder: CircleBorder(),
        child: Container(
          alignment: Alignment.center,
          height: 72,
          width: 72,
          child: Text(
            "Quay",
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
        ),
        onTap: () {
          homeController.showDialog(homeController.questions[Random().nextInt(homeController.questions.length)]);
        },
      ),
    );
  }
}
