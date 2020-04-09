library indefiniteprogressindicator;

import 'dart:math' as math;
import 'package:flutter/material.dart';

const double _kDefaultIndicatorRadius = 10.0;
const double _kTwoPI = math.pi * 2.0;
const int _kTickCount = 12;
const List<int> _alphaValues = <int>[147, 131, 114, 97, 81, 64, 47, 47, 47, 47, 47, 47];

class IndefiniteProgressIndicator extends StatefulWidget {
  /// Creates an iOS-style activity indicator that spins clockwise.
  const IndefiniteProgressIndicator({
    Key key,
    this.activeColor,
    this.animating = true,
    this.radius = _kDefaultIndicatorRadius,
  })  : assert(animating != null),
        assert(radius != null),
        assert(radius > 0),
        super(key: key);

  /// Whether the activity indicator is running its animation.
  ///
  /// Defaults to true.
  final bool animating;

  /// Active color
  final Color activeColor;

  /// Radius of the spinner widget.
  ///
  /// Defaults to 10px. Must be positive and cannot be null.
  final double radius;

  @override
  _IndefiniteProgressIndicatorState createState() => _IndefiniteProgressIndicatorState();
}

class _IndefiniteProgressIndicatorState extends State<IndefiniteProgressIndicator> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    if (widget.animating) _controller.repeat();
  }

  @override
  void didUpdateWidget(IndefiniteProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animating != oldWidget.animating) {
      if (widget.animating) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.radius * 2,
      width: widget.radius * 2,
      child: CustomPaint(
        painter: _IndefiniteProgressIndicatorPainter(
          position: _controller,
          activeColor: widget.activeColor,
          radius: widget.radius,
        ),
      ),
    );
  }
}

class _IndefiniteProgressIndicatorPainter extends CustomPainter {
  _IndefiniteProgressIndicatorPainter({
    @required this.position,
    @required this.activeColor,
    double radius,
  })  : tickFundamentalRRect = RRect.fromLTRBXY(
          -radius,
          radius / _kDefaultIndicatorRadius,
          -radius / 2.0,
          -radius / _kDefaultIndicatorRadius,
          radius / _kDefaultIndicatorRadius,
          radius / _kDefaultIndicatorRadius,
        ),
        super(repaint: position);

  final Animation<double> position;
  final RRect tickFundamentalRRect;
  final Color activeColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    canvas.save();
    canvas.translate(size.width / 2.0, size.height / 2.0);

    final int activeTick = (_kTickCount * position.value).floor();

    for (int i = 0; i < _kTickCount; ++i) {
      final int t = (i + activeTick) % _kTickCount;
      paint.color = activeColor.withAlpha(_alphaValues[t]);
      canvas.drawRRect(tickFundamentalRRect, paint);
      canvas.rotate(-_kTwoPI / _kTickCount);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_IndefiniteProgressIndicatorPainter oldPainter) {
    return oldPainter.position != position || oldPainter.activeColor != activeColor;
  }
}
