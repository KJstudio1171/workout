import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'dart:math' as Math;

void main() {
  runApp(TestWidget());
}

enum Mode { TIMER, STOPWATCH }

class CircleProgressBar extends StatefulWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final num time;
  final double value;
  final double strokeWidth;

  const CircleProgressBar({
    Key key,
    this.backgroundColor,
    @required this.strokeWidth,
    @required this.foregroundColor,
    @required this.value,
    @required this.time,
  }) : super(key: key);

  @override
  _CircleProgressBarState createState() => _CircleProgressBarState();
}

class _CircleProgressBarState extends State<CircleProgressBar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> curve;
  Tween<double> valueTween;
  Tween<Color> foregroundColorTween;

  @override
  void initState() {
    super.initState();
    this._controller = AnimationController(
      duration: Duration(seconds: this.widget.time),
      vsync: this,
    );
    this.curve = CurvedAnimation(
      parent: this._controller,
      curve: Curves.linear,
    );
    this._controller.forward();
    this.valueTween = Tween<double>(begin: 0, end: this.widget.value);
    this.foregroundColorTween = ColorTween(begin: Colors.greenAccent,end: this.widget.foregroundColor);
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = this.widget.backgroundColor;
    return AspectRatio(
      aspectRatio: 1,
      child: AnimatedBuilder(
          animation: this.curve,
          child: Container(),
          builder: (context, child) {
            final foregroundColor =
                this.foregroundColorTween?.evaluate(this.curve) ??
                    this.widget.foregroundColor;

            return CustomPaint(
              child: child,
              foregroundPainter: CircleProgressBarPainter(
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                percentage: this.valueTween.evaluate(this.curve),
                strokeWidth: 8,
              ),
            );
          }),
    );
  }

  @override
  void didUpdateWidget(covariant CircleProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (this.widget.value != oldWidget.value) {
      double beginValue =
          this.valueTween?.evaluate(this.curve) ?? oldWidget?.value ?? 0;

      // Update the value tween.
      this.valueTween = Tween<double>(
        begin: beginValue,
        end: this.widget.value ?? 1,
      );


      if (oldWidget.foregroundColor != this.widget.foregroundColor) {
        this.foregroundColorTween = ColorTween(
          begin: oldWidget?.foregroundColor,
          end: this.widget.foregroundColor,
        );
      } else {
        this.foregroundColorTween = null;
      }

      this._controller
        ..value = 0
        ..forward();
    }
  }
}

class CircleProgressBarPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color backgroundColor;
  final Color foregroundColor;

  CircleProgressBarPainter({
    this.backgroundColor,
    @required this.foregroundColor,
    @required this.percentage,
    @required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final Size constrainedSize =
        size - Offset(this.strokeWidth, this.strokeWidth);
    final shortestSide =
        Math.min(constrainedSize.width, constrainedSize.height);
    final foregroundPaint = Paint()
      ..color = this.foregroundColor
      ..strokeWidth = this.strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final radius = (shortestSide / 2);

    // Start at the top. 0 radians represents the right edge
    final double startAngle = -(2 * Math.pi * 0.25);
    final double sweepAngle = (2 * Math.pi * (this.percentage ?? 0));

    // Don't draw the background if we don't have a background color
    if (this.backgroundColor != null) {
      final backgroundPaint = Paint()
        ..color = this.backgroundColor
        ..strokeWidth = this.strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, backgroundPaint);
    }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as CircleProgressBarPainter);
    return oldPainter.percentage != this.percentage ||
        oldPainter.backgroundColor != this.backgroundColor ||
        oldPainter.foregroundColor != this.foregroundColor ||
        oldPainter.strokeWidth != this.strokeWidth;
  }
}

class TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  Mode mode = Mode.TIMER;
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              child: CircleProgressBar(
                value: 1,
                strokeWidth: 3,
                backgroundColor:  Colors.deepOrangeAccent,
                foregroundColor: Colors.blue,
                time: 2,
              ),
            )
            ,
            Container(
              width: 200,
              height: 200,
              child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    intensity: 1.0,
                    boxShape: NeumorphicBoxShape.circle(),
                    lightSource: LightSource.topLeft,
                    depth: -2,
                    color: Colors.greenAccent),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,children: [
              Container(
                width: 80,
                height: 80,
                child: NeumorphicButton(
                  onPressed: (){},
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      intensity: 1.0,
                      boxShape: NeumorphicBoxShape.circle(),
                      lightSource: LightSource.topLeft,
                      depth: 5,
                      color: Colors.greenAccent),
                ),
              ),Container(
                width: 80,
                height: 80,
                child: NeumorphicButton(
                  onPressed: (){},
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      intensity: 1.0,
                      boxShape: NeumorphicBoxShape.circle(),
                      lightSource: LightSource.topLeft,
                      depth: 5,
                      color: Colors.greenAccent),
                ),
              ),Container(
                width: 80,
                height: 80,
                child: NeumorphicButton(
                  onPressed: (){},
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      intensity: 1.0,
                      boxShape: NeumorphicBoxShape.circle(),
                      lightSource: LightSource.topLeft,
                      depth: 5,
                      color: Colors.greenAccent),
                ),
              )
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width:100,
                  height: 100,
                  child: NeumorphicToggle(
                      selectedIndex:selected,
                      onChanged: (value){
                        setState(() {
                          selected = value;
                        });
                      },
                      children: [
                    ToggleElement(), ToggleElement(),
                  ], thumb: null),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
