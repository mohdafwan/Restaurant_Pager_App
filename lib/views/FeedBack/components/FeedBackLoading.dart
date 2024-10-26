import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension LoadingAnimationControllerX on AnimationController {
  T eval<T>(Tween<T> tween, {Curve curve = Curves.linear}) =>
      tween.transform(curve.transform(value));

  double evalDouble({
    double from = 0,
    double to = 1,
    double begin = 0,
    double end = 1,
    Curve curve = Curves.linear,
  }) {
    return eval(
      Tween<double>(begin: from, end: to),
      curve: Interval(begin, end, curve: curve),
    );
  }
}

class WaveDots extends StatefulWidget {
  const WaveDots({
    super.key,
  });

  @override
  WaveDotsState createState() => WaveDotsState();
}

class WaveDotsState extends State<WaveDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final double size;
  late final Color color1, color2, color3;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    size = 50;
    color1 = const Color.fromRGBO(18, 194, 233, 1);
    color2 = const Color.fromRGBO(6, 0, 194, 1);
    color3 = const Color.fromRGBO(242, 58, 2, 1);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isVisible = false;
      });
      _controller.dispose();
    });
  }

  Widget _buildDot({
    required Offset begin,
    required Offset end,
    required Interval interval,
    required Color color,
  }) =>
      Transform.translate(
        offset: _controller.eval(
          Tween<Offset>(begin: begin, end: end),
          curve: interval,
        ),
        child: Container(
          width: size / 5,
          height: size / 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      );

  Widget _buildBottomDot({required double begin, required double end, required Color color}) {
    final double offset = -size / 8;
    return _buildDot(
      begin: Offset.zero,
      end: Offset(0.0, offset),
      interval: Interval(begin, end),
      color: color,
    );
  }

  Widget _buildTopDot({required double begin, required double end, required Color color}) {
    final double offset = -size / 8;
    return _buildDot(
      begin: Offset(0.0, offset),
      end: Offset.zero,
      interval: Interval(begin, end),
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _controller.value <= 0.50
                    ? _buildBottomDot(begin: 0.12, end: 0.50, color: color1)
                    : _buildTopDot(begin: 0.62, end: 1.0, color: color1),
                _controller.value <= 0.44
                    ? _buildBottomDot(begin: 0.06, end: 0.44, color: color2)
                    : _buildTopDot(begin: 0.56, end: 0.94, color: color2),
                _controller.value <= 0.38
                    ? _buildBottomDot(begin: 0.0, end: 0.38, color: color3)
                    : _buildTopDot(begin: 0.50, end: 0.88, color: color3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
