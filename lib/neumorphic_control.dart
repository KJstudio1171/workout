import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:workout/database/mapstructure.dart';
import 'package:workout/lib_control/theme_control.dart';
import 'set_control.dart';
import 'dart:async';

class PlusButton extends StatefulWidget {
  PlusButton(this.setSetter, this.addList);

  final Function(WorkoutData) setSetter;
  final Function() addList;

  @override
  _PlusButtonState createState() => _PlusButtonState();
}

class _PlusButtonState extends State<PlusButton> {
  List<String> result;
  WorkoutData setData = WorkoutData();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 68,
          width: 68,
          child: InkWell(
            enableFeedback: true,
            borderRadius: BorderRadius.circular(50),
            onTap: () async {
              result = await Get.to(Info());
              setData.set = int.tryParse(result[0]);
              setData.weight = num.tryParse(result[1]);
              setData.reps = int.tryParse(result[2]);
              setData.time = num.tryParse(result[3]);
              setData.unitWeight = result[4];
              setData.unitTime = result[5];
              await widget.setSetter(setData);
              widget.addList();
            },
            child: Icon(Icons.add),
          ),
        ),
        Text('set 추가'),
      ],
    );
  }
}

class DeleteSetButton extends StatefulWidget {
  DeleteSetButton(this.workoutData, this.index);

  WorkoutData workoutData;
  int index;
  bool _pressed = false;

  get getPressed => _pressed;

  @override
  _DeleteSetButtonState createState() => _DeleteSetButtonState();
}

class _DeleteSetButtonState extends State<DeleteSetButton> {
  Widget weightText() {
    if (widget.workoutData.weight != null && widget.workoutData.weight != 0) {
      return Text(
          '${widget.workoutData.weight}' + '${widget.workoutData.weight}');
    } else {
      return Text('');
    }
  }

  Widget repsOrTimeText() {
    if (widget.workoutData.reps == null || widget.workoutData.reps == 0) {
      switch (widget.workoutData.unitTime) {
        case '분':
          return Text(
            '${widget.workoutData.time}\'' + '00\"',
            style: TextStyle(
                fontSize: 17,
                color: widget._pressed ? Colors.white : Colors.black),
          );
          break;
        case '시간':
          return Text(
            '${widget.workoutData.time}\°' + '00\'' + '00\"',
            style: TextStyle(
                fontSize: 17,
                color: widget._pressed ? Colors.white : Colors.black),
          );
          break;
        default:
          return Text(
            '${widget.workoutData.time}\"',
            style: TextStyle(
                fontSize: 17,
                color: widget._pressed ? Colors.white : Colors.black),
          );
          break;
      }
    } else {
      return Text(
        '${widget.workoutData.reps}' + 'x',
        style: TextStyle(
            fontSize: 17, color: widget._pressed ? Colors.white : Colors.black),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 68,
          child: InkWell(
              borderRadius: BorderRadius.circular(50),
              enableFeedback: false,
              onTap: () {
                setState(() {
                  widget._pressed = !widget._pressed;
                });
              },
              child: widget._pressed
                  ? Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        intensity: 1.0,
                        boxShape: NeumorphicBoxShape.circle(),
                        lightSource: LightSource.topLeft,
                        depth: -2,
                        color: color11,
                      ),
                      child: Center(
                          child: Text(
                        '삭제',
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      )))
                  : Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        intensity: 1.0,
                        boxShape: NeumorphicBoxShape.circle(),
                        lightSource: LightSource.topLeft,
                        depth: 0,
                        color: Colors.grey[200],
                      ),
                      child: Center(
                        child: repsOrTimeText(),
                      ),
                    )),
        ),
        weightText(),
      ],
    );
  }
}

class SetButton extends StatefulWidget {
  SetButton(this.workoutData, this.index);

  WorkoutData workoutData;
  int index;

  @override
  _SetButtonState createState() => _SetButtonState();
}

class _SetButtonState extends State<SetButton>
    with SingleTickerProviderStateMixin {

  int _reps;
  Timer _timer;
  num _time = 0;
  bool _pressed = false;
  bool _paused = true;
  List<int> saveReps;
  List<num> saveTime;

  AnimationController _controller;
  DecorationTween _animation = DecorationTween(
    begin: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4.0,
            spreadRadius: 2.0,
          )
        ]),
    end: BoxDecoration(
      color: Colors.grey[200],
      shape: BoxShape.circle,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.grey,
          blurRadius: 0.0,
          spreadRadius: 0.0,
        )
      ],
    ),
  );

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    saveReps=widget.workoutData.saveReps;
    saveTime=widget.workoutData.saveTime;
    saveReps[widget.index]=0;
    saveTime[widget.index]=0;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
    _reps = widget.workoutData.reps;
    super.initState();
  }

  void _start() {
    _paused = false;
    var _timeStart;

    switch (widget.workoutData.unitTime) {
      case '분':
        _timeStart = widget.workoutData.time * 60;
        break;
      case '시간':
        _timeStart = widget.workoutData.time * 3600;
        break;
      default:
        _timeStart = widget.workoutData.time;
        break;
    }

    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_time < _timeStart) {
        setState(() {
          _time++;
        });
      } else {
        setState(() {
          _paused = true;
          _pressed = true;
        });
        _timer.cancel();
      }
    });
  }

  void _pause() {
    _paused = true;
    _timer.cancel();
  }

  void _reset() {
    setState(() {
      _paused = true;
      _timer.cancel();
      _time = 0;
    });
  }

  void repsOrTime1() {
    if (widget.workoutData.reps == null || widget.workoutData.reps == 0) {
      setState(() {
        if (_pressed == true) {
          _reset();
          _pressed = false;
        } else {
          if (_paused) {
            _start();
          } else {
            _pause();
          }
        }
      });
    } else {//
      setState(() {
        if (_pressed == true) {
          if (_reps == 1) {
            _pressed = false;
          }
          _reps = (_reps - 2) % widget.workoutData.reps + 1;
          saveReps[widget.index]=_reps;
          print( widget.workoutData.saveReps);
        } else {
          _pressed = true;
        }
      });
    }
  }

  void repsOrTime2() {
    if (widget.workoutData.reps == null || widget.workoutData.reps == 0) {
      setState(() {
        if (_pressed == true) {
          _start();
          _pressed = false;
        } else {
          _pressed = true;
          _pause();
        }
      });
    } else {
      setState(() {
        if (_pressed == true) {
          if (_reps == 1) {
            _pressed = false;
          }
          _reps = (_reps - 2) % widget.workoutData.reps + 1;
        } else {
          _pressed = true;
        }
      });
    }
  }

  void repsOrTime3() {
    var _timeStart;
    if (widget.workoutData.time != null) {
      switch (widget.workoutData.unitTime) {
        case '분':
          _timeStart = widget.workoutData.time * 60;
          break;
        case '시간':
          _timeStart = widget.workoutData.time * 3600;
          break;
        default:
          _timeStart = widget.workoutData.time;
          break;
      }
    }
    if (widget.workoutData.reps == null || widget.workoutData.reps == 0) {
      setState(() {
        if (_pressed == true) {
          _start();
          _pressed = false;
        } else {
          _pressed = true;
          _pause();
          _time = _timeStart;
        }
      });
    } else {
      setState(() {
        if (_pressed == true) {
          _pressed = false;
          _reps = widget.workoutData.reps;
        } else {
          _pressed = true;
        }
      });
    }
  }

  Widget repsOrTimeText() {
    var sec = _time % 60;
    var min = (_time ~/ 60) % 60;
    var hour = _time ~/ 3600;
    if (widget.workoutData.reps == null || widget.workoutData.reps == 0) {
      switch (widget.workoutData.unitTime) {
        case '분':
          return Text(
            '$min\'' + '$sec\"',
            style: TextStyle(
                fontSize: 17, color: _pressed ? Colors.white : Colors.black),
          );
          break;
        case '시간':
          return Text(
            '$hour\°' + '$min\'' + '$sec\"',
            style: TextStyle(
                fontSize: 17, color: _pressed ? Colors.white : Colors.black),
          );
          break;
        default:
          return Text(
            '$_time\"',
            style: TextStyle(
                fontSize: 17, color: _pressed ? Colors.white : Colors.black),
          );
          break;
      }
    } else {
      return Text(
        '$_reps' + 'x',
        style: TextStyle(
            fontSize: 17, color: _pressed ? Colors.white : Colors.black),
      );
    }
  }

  Widget weightText() {
    if (widget.workoutData.weight != null && widget.workoutData.weight != 0) {
      return Text(
          '$widget.setData.weight}' + '${widget.workoutData.unitWeight}');
    } else {
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 68,
          width: 68,
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            enableFeedback: false,
            onTap: () {
              repsOrTime1();
            },
            onDoubleTap: () {
              repsOrTime2();
            },
            onLongPress: () {
              repsOrTime3();
            },
            child: _paused
                ? Neumorphic(
                    style: _pressed
                        ? NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            intensity: 1.0,
                            boxShape: NeumorphicBoxShape.circle(),
                            lightSource: LightSource.topLeft,
                            depth: -2,
                            color: Color.fromARGB(255, 161, 196, 253),
                          )
                        : NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            intensity: 1.0,
                            boxShape: NeumorphicBoxShape.circle(),
                            lightSource: LightSource.topLeft,
                            depth: 0,
                            color: Colors.grey[200],
                          ),
                    child: Center(
                      child: repsOrTimeText(),
                    ),
                  )
                : DecoratedBoxTransition(
                    decoration: _animation.animate(_controller),
                    child: Center(
                      child: repsOrTimeText(),
                    ),
                  ),
          ),
        ),
        weightText(),
      ],
    );
  }
}
