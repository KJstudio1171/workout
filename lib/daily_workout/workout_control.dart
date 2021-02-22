import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import 'package:workout/lib_control/theme_control.dart';
import 'package:workout/daily_workout/neumorphic_control.dart';
import 'package:workout/database/workout_firestore.dart';
import 'package:workout/database/maindata_control.dart';

class RoutineList extends StatefulWidget {
  RoutineList(this.routineData);

  final Map routineData;

  @override
  _RoutineListState createState() => _RoutineListState();
}

class _RoutineListState extends State<RoutineList> {
  List<Widget> activeWorkoutList = [];
  List listData = [];
  String routineName;

  InkWell inkWell() {
    return InkWell(
      enableFeedback: true,
      child: ListTile(
        title: Text('운동추가하기'),
        leading: Icon(Icons.add),
      ),
      onTap: () async {
        List result = await Get.to(FireStoreSelectWorkout());
        List<Widget> _list;
        if (activeWorkoutList.isEmpty) {
          activeWorkoutList.add(inkWell());
          _list = activeWorkoutList;
        } else {
          _list = activeWorkoutList;
        }
        _list.removeLast();
        result.forEach((element) {
          _list.add(WorkoutList(routineName, element[0], listData, element[1]));
        });
        _list.add(inkWell());
        setState(() {
          activeWorkoutList = _list;
        });
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    activeWorkoutList.clear();
    super.dispose();
  }

  @override
  void initState() {
    routineName = widget.routineData['routine_name'];
    widget.routineData['wko_names'].forEach((key, value) {
      activeWorkoutList.add(WorkoutList(routineName, key, value['set_info'],value['category']));
    });
    activeWorkoutList.add(inkWell());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        routineName,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
      onExpansionChanged: (bool) {},
      maintainState: true,
      children: [
        ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Dismissible(
                key: UniqueKey(),
                onDismissed: (DismissDirection direction) {
                  setState(() {
                    activeWorkoutList.removeAt(index);
                  });
                },
                secondaryBackground: Container(
                  child: Center(
                    child: Text(
                      '삭제',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  color: color11,
                ),
                background: Container(),
                direction: DismissDirection.endToStart,
                child: activeWorkoutList[index]);
          },
          itemCount: activeWorkoutList.length,
        ),
      ],
    );
  }
}

class WorkoutList extends StatefulWidget {
  WorkoutList(this.routineName, this.workoutName, this.fireStoreWorkoutData, this.workoutCategory);

  final String routineName;
  final String workoutName;
  final String workoutCategory;
  final List fireStoreWorkoutData;

  @override
  _WorkoutListState createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  bool delete = false;
  bool expansion = true;

  List<Widget> _activeSetList = [];
  List<Widget> _setList = [];
  List<DeleteSetButton> _deleteSetList = [];
  List<int> _delete = [];

  WorkoutData setData = WorkoutData();

  setSetter(WorkoutData workoutData) {
    this.setData = workoutData;
    WorkoutSaveData.addRawData(
        widget.routineName, widget.workoutName, this.setData ,  widget.workoutCategory);
  }

  addList() {
    this._setList.removeLast();
    List<Widget> _list = this._setList;
    List<Widget> _list2 = this._deleteSetList;
    for (int i = 0; i < this.setData.set; i++) {
      setData.saveReps.add(0);
      setData.saveTime.add(0);
      _list.add(SetButton(this.setData, i));
      _list2.add(DeleteSetButton(this.setData, i));
    }
    setState(() {
      this._setList = _list;
      this._deleteSetList = _list2;
    });
    _setList.add(PlusButton(setSetter, addList));
    setState(() {
      _activeSetList = _setList;
      delete = false;
    });
  }

  @override
  void initState() {
    widget.fireStoreWorkoutData.forEach((element) {
      WorkoutData workoutData = WorkoutData();
      WorkoutSaveData.addRawData(
          widget.routineName, widget.workoutName, workoutData,widget.workoutCategory);
      for (int i = 0; i < int.parse(element['set']); i++) {
        workoutData.saveReps.add(0);
        workoutData.saveTime.add(0);
        workoutData.set = int.parse(element['set']) ?? null;
        workoutData.weight = num.tryParse(element['weight']) ?? null;
        workoutData.reps = int.tryParse(element['reps']) ?? null;
        workoutData.time = num.tryParse(element['time']) ?? null;
        workoutData.unitWeight = element['unit_weight'];
        workoutData.unitTime = element['unit_time'];
        _setList.add(SetButton(workoutData, i));
        _deleteSetList.add(DeleteSetButton(workoutData, i));
      }
    });
    _setList.add(PlusButton(setSetter, addList));
    _activeSetList = _setList;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.fireStoreWorkoutData.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(
        widget.workoutName,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      trailing: expansion
          ? delete
              ? InkWell(
                  enableFeedback: false,
                  onTap: () {
                    setState(() {
                      for (int i = 0; i < _deleteSetList.length; i++) {
                        if (_deleteSetList[i].getPressed == true) {
                          _delete.add(i);
                          _deleteSetList[i]
                              .workoutData
                              .saveReps[_deleteSetList[i].index] = 0;
                          _deleteSetList[i]
                              .workoutData
                              .saveTime[_deleteSetList[i].index] = 0;
                        }
                      }
                      for (int i = _delete.length - 1; 0 <= i; i--) {
                        _deleteSetList.removeAt(_delete[i]);
                        _setList.removeAt(_delete[i]);
                      }
                      _delete.clear();
                      _activeSetList = _setList;
                      delete = false;
                    });
                  },
                  child: Text(
                    '확인',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                )
              : InkWell(
                  enableFeedback: false,
                  onTap: () {
                    setState(() {
                      if (_setList.length != 1) {
                        delete = true;
                        _activeSetList = _deleteSetList;
                      }
                    });
                  },
                  child: Text(
                    'set 삭제',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                )
          : Icon(Icons.keyboard_arrow_down_outlined),
      onExpansionChanged: (bool) {
        setState(() {
          expansion = !expansion;
        });
      },
      maintainState: true,
      children: [
        GridView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 9,
            mainAxisSpacing: 9,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (_, index) {
            return _activeSetList[index];
          },
          itemCount: _activeSetList.length,
        ),
      ],
    );
  }
}

/*class ButtonPressed with ChangeNotifier {
  bool _pressed = false;

  bool getPressed() {
    notifyListeners();
    return _pressed;
  }

  changePressed() {
    notifyListeners();
    return _pressed = !_pressed;
  }

  setPressed(bool pressed) {
    notifyListeners();
    return _pressed = pressed;
  }
}  */

/*class ModeChanger extends GetxController {
  var _modify = false;
  var _delete = false;

  bool getModify() {
    update();
    return _modify;}

  bool getDelete()  {
    update();
    return _delete;}

  changePressed() => _modify = !_modify;

  static ModeChanger get to => Get.find();

  setModify(bool modify) {
    update();
    return _modify = modify;
  }

  setDelete(bool delete) {
    update();
    return _delete = delete;
  }
}*/
