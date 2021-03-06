import 'dart:async';
import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../lib_control/theme_control.dart';

class TimerDialog extends StatefulWidget {
  @override
  _TimerDialogState createState() => _TimerDialogState();
}

class _TimerDialogState extends State<TimerDialog>
    with TickerProviderStateMixin {
  bool _mode = false;
  bool _paused = false;
  bool _play = false;
  bool _stop = true;
  Text timerText;

  Timer _timer;
  num _progressTime = 0;
  num _visualTime = 0;
  num _stopWatchTime = 0;

  double up = 8;
  double down = -3;
  EdgeInsets edgeInsets = EdgeInsets.fromLTRB(10, 10, 10, 15);

  String appbar = '카운트다운';

  AnimationController controller;
  num time = 2;

  Color background = color15;

  @override
  void initState() {
    this.controller = AnimationController(
      duration: Duration(seconds: time),
      vsync: this,
    );
    super.initState();
    timerText = Text(
      '$_visualTime',
      style: TextStyle(fontSize: 65, fontFamily: 'labdigital'),
    );
  }

  @override
  void setState(fn) {
    timeCal();
    if (_visualTime <= 10) {
      timerText = Text(
        '$_visualTime',
        style: TextStyle(fontSize: 65, fontFamily: 'labdigital'),
      );
    } else if (_visualTime <= 60) {
      timerText = Text(
        '${_visualTime ~/ 10}' '${_visualTime % 10}',
        style: TextStyle(fontSize: 65, fontFamily: 'labdigital'),
      );
    } else {
      timerText = Text(
        '${_visualTime ~/ 60}' +
            ':' '${_visualTime % 60 ~/ 10}' '${_visualTime % 60 % 10}',
        style: TextStyle(fontSize: 65, fontFamily: 'labdigital'),
      );
    }
    super.setState(fn);
  }

  @override
  void dispose() {
    this.controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
        title: Text(
          appbar,
          style: TextStyle(color: color2, fontFamily: 'godo'),
        ),
      ),
      backgroundColor: background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /*SizedBox(height: 10,),
          Center(child: Text('countdown',
            style: TextStyle(fontFamily: 'labdigital', fontSize:30),),),
          SizedBox(height: 20,),*/
          Container(
            width: 320,
            height: 320,
            margin: EdgeInsets.only(top: 20, bottom: 38),
            child: CircleProgressBar(
              controller: this.controller,
              value: 1,
              strokeWidth: 5,
              backgroundColor: color1,
              foregroundColor: color7,
              timerText: timerText,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              containerButton(60),
              containerButton(30),
              containerButton(10),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 80,
                  height: 80,
                  margin: edgeInsets,
                  child: InkWell(
                    onTap: () {
                      if (!_paused) _pause();
                      this.controller.stop();
                      setState(() {
                        _paused = true;
                        _play = false;
                        _stop = false;
                      });
                    },
                    child: _paused
                        ? Neumorphic(
                            child: Icon(
                              Icons.pause,
                              size: 25,
                              color: color13,
                            ),
                            style: NeumorphicStyle(
                                border:
                                    NeumorphicBorder(width: 2, color: color13),
                                intensity: 1,
                                depth: down,
                                color: background),
                          )
                        : Neumorphic(
                            child: Icon(
                              Icons.pause,
                              size: 25,
                            ),
                            style: NeumorphicStyle(
                                shape: NeumorphicShape.convex,
                                border:
                                    NeumorphicBorder(width: 2, color: color1),
                                intensity: 1,
                                depth: up,
                                color: background),
                          ),
                  )),
              Container(
                  width: 80,
                  height: 80,
                  margin: edgeInsets,
                  child: InkWell(
                    onTap: () {
                      if (!_play) {
                        _start();
                      }
                      setState(() {
                        _play = true;
                        _paused = false;
                        _stop = false;
                      });
                    },
                    child: _play
                        ? Neumorphic(
                            child: Icon(
                              Icons.play_arrow_sharp,
                              size: 25,
                              color: color11,
                            ),
                            style: NeumorphicStyle(
                                border:
                                    NeumorphicBorder(width: 2, color: color11),
                                intensity: 1,
                                depth: down,
                                color: background),
                          )
                        : Neumorphic(
                            child: Icon(
                              Icons.play_arrow_sharp,
                              size: 25,
                            ),
                            style: NeumorphicStyle(
                                shape: NeumorphicShape.convex,
                                border:
                                    NeumorphicBorder(width: 2, color: color1),
                                intensity: 1,
                                depth: up,
                                color: background),
                          ),
                  )),
              Container(
                  width: 80,
                  height: 80,
                  margin: edgeInsets,
                  child: InkWell(
                    onTap: () {
                      if (!_stop) _reset();
                      this.controller.reset();
                      this.controller.stop();
                      setState(() {
                        _stop = true;
                        _play = false;
                        _paused = false;
                      });
                    },
                    child: _stop
                        ? Neumorphic(
                            child: Icon(
                              Icons.stop,
                              size: 25,
                              color: color3,
                            ),
                            style: NeumorphicStyle(
                                border:
                                    NeumorphicBorder(width: 2, color: color3),
                                intensity: 1,
                                depth: down,
                                color: background),
                          )
                        : Neumorphic(
                            child: Icon(
                              Icons.stop,
                              size: 25,
                            ),
                            style: NeumorphicStyle(
                                shape: NeumorphicShape.convex,
                                border:
                                    NeumorphicBorder(width: 2, color: color1),
                                intensity: 1,
                                depth: up,
                                color: background),
                          ),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 130,
                  height: 50,
                  margin: edgeInsets,
                  child: InkWell(
                    onTap: () {
                      _reset();
                      _stop = true;
                      _play = false;
                      _paused = false;
                      this.controller.stop();
                      _stopWatchTime = 0;
                      _progressTime = 0;
                      this.controller.reset();
                      this.controller.stop();
                      setState(() {
                        _mode = false;
                        appbar = '카운트다운';
                      });
                    },
                    child: _mode
                        ? Neumorphic(
                            child: Icon(Icons.access_alarm),
                            style: NeumorphicStyle(
                                shape: NeumorphicShape.convex,
                                border:
                                    NeumorphicBorder(width: 2, color: color1),
                                intensity: 1,
                                depth: up,
                                color: background))
                        : Neumorphic(
                            child: Icon(
                              Icons.access_alarm,
                              color: color7,
                            ),
                            style: NeumorphicStyle(
                                border:
                                    NeumorphicBorder(width: 2, color: color1),
                                intensity: 1,
                                depth: down,
                                color: background),
                          ),
                  )),
              Container(
                width: 130,
                height: 50,
                margin: edgeInsets,
                child: InkWell(
                  onTap: () {
                    _reset();
                    _stop = true;
                    _play = false;
                    _paused = false;
                    this.controller.stop();
                    _stopWatchTime = 0;
                    _progressTime = 0;
                    this.controller = AnimationController(
                      duration: Duration(seconds: 1),
                      vsync: this,
                    )..addListener(() {
                        this.controller.repeat();
                      });
                    setState(() {
                      _mode = true;
                      appbar = '스탑와치';
                    });
                  },
                  child: _mode
                      ? Neumorphic(
                          child:
                              Icon(Icons.watch_later_outlined, color: color7),
                          style: NeumorphicStyle(
                              border: NeumorphicBorder(width: 2, color: color1),
                              intensity: 1,
                              depth: down,
                              color: background),
                        )
                      : Neumorphic(
                          child: Icon(Icons.watch_later_outlined),
                          style: NeumorphicStyle(
                              shape: NeumorphicShape.convex,
                              border: NeumorphicBorder(width: 2, color: color1),
                              intensity: 1,
                              depth: up,
                              color: background),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container containerButton(int time) {
    return Container(
      width: 80,
      height: 80,
      margin: edgeInsets,
      child: NeumorphicButton(
        child: Center(
          child: Text(
            '+' + '$time' + '초',
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'godo',
              color: _mode ? Colors.black26 : color2,
            ),
          ),
        ),
        onPressed: () {
          _progressTime = 0;
          if (!_mode) {
            if (_stopWatchTime == 0) {
              _progressTime = 0;
            }
            _stopWatchTime += time;
            this.controller = AnimationController(
              duration: Duration(seconds: _stopWatchTime),
              vsync: this,
            );
            if (_play) this.controller.forward();
            setState(() {});
          }
        },
        style: NeumorphicStyle(
            border: NeumorphicBorder(width: 2, color: color1),
            shape: _mode ? NeumorphicShape.flat : NeumorphicShape.convex,
            //border: NeumorphicBorder(width: 5),
            intensity: 1.0,
            boxShape: NeumorphicBoxShape.circle(),
            lightSource: LightSource.topLeft,
            depth: _mode ? down : up,
            color: background),
      ),
    );
  }

  void timeCal() {
    if (_mode) {
      _visualTime = _progressTime;
    } else {
      if (_stopWatchTime - _progressTime >= 0)
        _visualTime = _stopWatchTime - _progressTime;
    }
  }

  void _start() {
    print('start');
    _paused = false;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _progressTime++;
      if (_mode == true || _stopWatchTime != 0) {
        this.controller.forward();
      }
      setState(() {});
    });
  }

  void _pause() {
    _paused = true;
    _timer?.cancel();
  }

  void _reset() {
    _stop = true;
    _progressTime = 0;
    _stopWatchTime = 0;
    _timer?.cancel();
  }
}

class CircleProgressBar extends StatefulWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final double value;
  final double strokeWidth;
  final Text timerText;
  final AnimationController controller;

  const CircleProgressBar({
    Key key,
    @required this.controller,
    @required this.foregroundColor,
    @required this.backgroundColor,
    @required this.strokeWidth,
    @required this.value,
    @required this.timerText,
  }) : super(key: key);

  @override
  _CircleProgressBarState createState() => _CircleProgressBarState();
}

class _CircleProgressBarState extends State<CircleProgressBar>
    with SingleTickerProviderStateMixin {
  Tween<double> valueTween;
  Tween<Color> foregroundColorTween;

  @override
  void initState() {
    super.initState();
    this.valueTween = Tween<double>(begin: 0, end: this.widget.value);
    this.foregroundColorTween =
        ColorTween(begin: color13, end: this.widget.foregroundColor);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = this.widget.backgroundColor;
    return AspectRatio(
      aspectRatio: 1,
      child: AnimatedBuilder(
          animation: this.widget.controller,
          child: Container(
            child: Neumorphic(
              child: Center(child: widget.timerText),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  intensity: 1.0,
                  boxShape: NeumorphicBoxShape.circle(),
                  lightSource: LightSource.topLeft,
                  depth: 10,
                  color: color15 ),
            ),
          ),
          builder: (context, child) {
            final foregroundColor =
                this.foregroundColorTween?.evaluate(this.widget.controller) ??
                    this.widget.foregroundColor;

            return CustomPaint(
              child: child,
              foregroundPainter: CircleProgressBarPainter(
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                percentage: this.valueTween.evaluate(this.widget.controller),
                strokeWidth: this.widget.strokeWidth,
              ),
            );
          }),
    );
  }

  @override
  void didUpdateWidget(covariant CircleProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (this.widget.value != oldWidget.value) {
      double beginValue = this.valueTween?.evaluate(this.widget.controller) ??
          oldWidget?.value ??
          0;

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

      this.widget.controller
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
    final radius = (shortestSide / 2 - 10);

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
