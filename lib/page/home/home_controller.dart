import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spin_wheel_app/models/model.dart';
import 'package:flutter_spin_wheel_app/models/question.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  Rx<AnimationController> _ctrl;
  Rx<Animation> ani;

  var angle = 0.0.obs;
  var current = 0.0.obs;
  var answer = ''.obs;
  var pos = (-35.0).obs;
  var items = <Luck>[
    Luck("1.000", Colors.accents[0]),
    Luck("2.000", Colors.accents[2]),
    Luck("5.000", Colors.accents[4]),
    Luck("10.000", Colors.accents[6]),
    Luck("20.000", Colors.accents[8]),
    Luck("50.000", Colors.accents[10]),
    Luck("100.000", Colors.accents[12]),
  ].obs;

  var questions = <Question>[
    Question('Năm nay là năm gì', 'Tân Sửu', 'Tân Sửu'),
    Question('Cậu có thích tớ không', 'Có', 'Có'),
    Question('Cậu làm người iu của tớ nhé \u{2764}', 'Ừm', 'Ừm'),
    Question('Trả lời gì cũng được', 'Gì cũng được', 'Gì cũng được'),
  ].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    print('init');
    var _duration = Duration(seconds: 5);
    _ctrl = AnimationController(vsync: this, duration: _duration).obs;
    ani = CurvedAnimation(parent: _ctrl.value, curve: Curves.fastLinearToSlowEaseIn).obs;
    animation2();
    super.onInit();
  }

  void transPos() {}

  void animation2() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (pos.value > 900) {
        pos.value = -35.0;
      }
      pos.value += 16;
    });
  }

  void animation() {
    if (!_ctrl.value.isAnimating) {
      var _random = Random().nextDouble();
      angle.value = 20.0 + Random().nextInt(5) + _random;
      _ctrl.value.forward(from: 0.0).then((_) {
        current.value = (current.value + _random);
        current.value = current.value - current.value ~/ 1;
        _ctrl.value.reset();
        showDialogCongratulations();
      });
    }
  }

  void showDialog(Question question) {
    Get.defaultDialog(
      title: 'Vui lòng trả lời câu hỏi để quay lì xì',
      titleStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
      backgroundColor: Colors.pink[100],
      content: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                '${question.quest}? (Gợi ý trả lời: ${question.suggest})',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: TextField(
                onChanged: (value) {
                  answer.value = value;
                },
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.pink[100],
                  hintText: '${question.suggest}',
                  hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white54),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      confirm: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
          boxShadow: [
            BoxShadow(
              color: Colors.pink[50].withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: FlatButton(
          onPressed: () {
            if (answer.toLowerCase().trim().endsWith(question.answer.toLowerCase().trim())) {
              answer.value = '';
              Get.back();
              animation();
            } else {
              Get.snackbar('Ôi bạn ơi!', 'Bạn trả lời sai rồi, trả lời lại đi :) ');
            }
          },
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Trả lời',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      cancel: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
          boxShadow: [
            BoxShadow(
              color: Colors.pink[50].withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: FlatButton(
          onPressed: () {
            Get.back();
          },
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Hủy',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void showDialogCongratulations() {
    Get.defaultDialog(
      title: 'Xin chúc mừng!',
      titleStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
      backgroundColor: Colors.pink[100],
      content: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                'Bạn đã được nhận ${items[calIndex(current.value)].price} lì xì từ Ly \n Năm mới vui vẻ.',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      confirm: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
          boxShadow: [
            BoxShadow(
              color: Colors.pink[50].withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: FlatButton(
          onPressed: () {
            angle.value = 0.0;
            current.value = 0.0;
            Get.back();
          },
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Ok',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  int calIndex(value) {
    var _base = (2 * pi / items.length / 2) / (2 * pi);
    return (((_base + value) % 1) * items.length).floor();
  }
}
