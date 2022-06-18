import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  const WaveClipper(this.animation, this.waveList1);

  final double animation;

  final List<Offset> waveList1;

  @override
  Path getClip(Size size) => Path()
    ..addPolygon(waveList1, false)
    ..lineTo(size.width, size.height)
    ..lineTo(0, size.height)
    ..close();

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      animation != oldClipper.animation;
}
