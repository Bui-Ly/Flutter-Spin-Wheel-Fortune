import 'dart:math';

import 'package:flutter/material.dart';

class ArrowView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Transform.rotate(
        angle: pi,
        child: Padding(
          padding: EdgeInsets.only(top: 80),
          child: ClipPath(
            clipper: _ArrowClipper(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black12,
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var _path = Path();
    var _center = size.center(Offset.zero);

    _path.lineTo(_center.dx, size.height);
    _path.lineTo(size.width, 0);
    _path.lineTo(_center.dx, _center.dy);
    _path.close();

    return _path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
