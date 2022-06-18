import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/animation.dart';

import 'wave_clipper.dart';

class TotalPrice extends StatefulWidget {
  const TotalPrice({this.price});

  final int price;

  @override
  _TotalPriceState createState() => _TotalPriceState();
}

class _TotalPriceState extends State<TotalPrice> with TickerProviderStateMixin {
  static const double degrees2Radians = pi / 180.0;

  AnimationController _animationController;
  List<Offset> _wavePoints = <Offset>[];

  double get _waveHeight => sqrt(widget.price);
  double get size => 8.0 * 60;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )
      ..addListener(_generateWavePoints)
      ..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.price == 0
      ? const SizedBox.shrink()
      : Transform.translate(
          offset: Offset(size * 0.5, size * 0.8),
          child: Transform.rotate(
            angle: -pi / 6,
            child: AnimatedBuilder(
              animation: CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
              builder: (BuildContext context, Widget child) => ClipPath(
                clipper: WaveClipper(_animationController.value, _wavePoints),
                child: child,
              ),
              child: Container(
                width: size,
                height: size,
                color: Theme.of(context).primaryColor,
                child: Transform.translate(
                  offset: Offset(size * 0.1, -size * 0.37),
                  child: Center(
                    child: Text(
                      '${(widget.price ?? '').toString()} ₽',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline6
                          .apply(fontSizeDelta: 8),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

  void _generateWavePoints() {
    final double time = _animationController.value;
    _wavePoints = List<Offset>.generate(
      size.toInt(),
      (int x) => Offset(
        x.toDouble(),
        sin((time * 360 - x) % 360 * degrees2Radians) * _waveHeight +
            _waveHeight,
      ),
    );
  }
}
