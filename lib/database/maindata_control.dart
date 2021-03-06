import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*var fireStoreMap = {
  'routine_name': 'name',
  'wko_category': {
    'workout_name': [
      {
        'reps': 'n',
        'set': 'n',
        'time': 'n',
        'unit_time': 'n',
        'unit_weight': 'n',
        'weight': 'n',
      },
    ]
  }
};*/

// List<Map> workoutSaveData = [];

class WorkoutData {
  int set = 0;
  int reps = 0;
  num weight = 0;
  num time = 0;
  String unitWeight = 'kg';
  String unitTime = '분';
  int sumReps = 0;
  num sumTime = 0;
  String visualData;

  List<int> saveReps = [];
  List<num> saveTime = [];
/* copyWorkoutData(WorkoutData original,WorkoutData copy){
    copy.set = original.set;
    copy.reps = original.reps;
    copy.weight = original.weight;
    copy.time = original.time;
    copy.unitWeight = original.unitWeight;
    copy.unitTime = original.unitTime;
  }*/

}

class WorkoutSaveData {
  static List rawData = [];
  static List resultDate = [];
  static Map resultData = {
    'routine': Set(),
    'category': Set(),
  };

  static addRawData(String routineName, String workoutName,
      WorkoutData workoutData, wkoCategory) {
    rawData.add([routineName, workoutName, workoutData, wkoCategory]);
  }

  static rawDataPreProcessing() {
    rawData.forEach((element) {
      WorkoutData workoutData = element[2];
      workoutData.reps == 0 || workoutData.reps == null
          ? workoutData.saveTime.forEach((element) {
              workoutData.sumTime += element;
            })
          : workoutData.saveReps.forEach((element) {
              workoutData.sumReps += element;
            });
      if (workoutData.sumReps != 0 || workoutData.sumTime != 0) {
        if (workoutData.reps == 0 || workoutData.reps == null) {
          workoutData.weight == 0 || workoutData.weight == null
              ? workoutData.visualData =
                  '${workoutData.sumTime}' + '${workoutData.unitTime}'
              : workoutData.visualData = '${workoutData.weight}' +
                  '${workoutData.unitWeight}' +
                  '${workoutData.sumTime}' +
                  '${workoutData.unitTime}';
        } else {
          workoutData.weight == 0 || workoutData.weight == null
              ? workoutData.visualData = '${workoutData.sumReps}' + '회'
              : workoutData.visualData = '${workoutData.weight}' +
                  '${workoutData.unitWeight}' +
                  '${workoutData.sumReps}' +
                  '회';
        }
      }
    });
  }

  static rawDataPostProcessing(DateTime dateTime) {
    print(rawData);
    rawData.forEach((element) {
      if (element[2].visualData != null) {
        resultData['routine'].add(element[0]);
        resultData['category'].add(element[3]);
        if (!resultData.containsKey(element[1])) {
          resultData.addAll({element[1]: []});
        }
        if (element[2].visualData != null)
          resultData[element[1]].add(element[2].visualData);
      }
    });
    if (resultData['routine'].isNotEmpty) {
      resultDate = [dateTime.year, dateTime.month, dateTime.day];
    }
    print(resultData);
  }

  static rawResultDataReset() {
    rawData = [];
    resultData = {
      'routine': Set(),
      'category': Set(),
    };
  }
}

class WorkoutParse {
  WorkoutParse(this.routine);

  final String routine;

  final String routineName = 'routine_name';
  final String wkoCategory = 'wko_category';
  final String set = "set";
  final String weight = 'weight';
  final String reps = 'reps';
  final String time = "time";
  final String unitWeight = 'unit_weight';
  final String unitTime = 'unit_time';
  final String datetime = 'datetime';

  Map workoutData = {};
  Map map = {};

  initRoutine() {
    if (this.workoutData[routineName] == null) {
      this.workoutData.addAll({routineName: this.routine, wkoCategory: {}});
    }
  }

  initWorkout(String workoutName) {
    if (this.workoutData[this.wkoCategory][workoutName] == null) {
      this.workoutData[this.wkoCategory].addAll({workoutName: {}});
    }
  }

  List initSetData(WorkoutData workoutData) {
    List list = List(5);
    list[0] = workoutData.weight;
    list[1] = 0; //reps
    list[2] = 0; //time
    list[3] = workoutData.unitWeight;
    list[4] = workoutData.unitTime;
    return list;
  }

  addRepsData(String workoutName, List list, int repsData) {
    if (this.workoutData[this.wkoCategory][workoutName].isEmpty) {
      this.workoutData[this.wkoCategory][workoutName].addAll({list: 1});
    }
    this.workoutData[this.wkoCategory][workoutName].forEach((key, value) {
      if (listEquals(list, key)) {
        return this
            .workoutData[this.wkoCategory][workoutName]
            .update(key, (value) => value + 1);
      }
      return this.workoutData[this.wkoCategory][workoutName].addAll({list: 1});
    });
    print(this.workoutData.toString());
  }

  addTimeData(String workoutName, List list, num timeData) {
    list[2] = timeData;

    if (this.workoutData[this.wkoCategory][workoutName][list] == null) {
      this.workoutData[this.wkoCategory][workoutName].addAll({list: 1});
    } else {
      this.workoutData[this.wkoCategory][workoutName][list] += 1;
    }
  }

  deleteSetData(String workoutName, WorkoutData setData) {
    List list;
    list[0] = setData.set;
    list[1] = setData.weight;
    list[2] = setData.reps;
    list[3] = setData.time;
    list[4] = setData.unitWeight;
    list[5] = setData.unitTime;
    this.workoutData[this.wkoCategory][workoutName].remove(list);
  }
}

class ResultDataFireStore {
  // 필드명
  final String resultData = 'resultData';
  final String routine = 'routine';
  final String workoutData = 'workout_data';
  final String date = 'date';
  final String identification = FirebaseAuth.instance.currentUser.uid;

  Map storedData = {};
  bool overlap = false;
  String documentID;

  resultDoc() {
    return FirebaseFirestore.instance
        .collection(identification)
        .doc(resultData)
        .collection(resultData);
  }

  overlapCheck(int year, int month, int day) async {
    await resultDoc()
        .where(date, isEqualTo: [year, month, day])
        .get()
        .then((value) => value.docs.forEach((element) {
              overlap = true;
              storedData = element.data()['workout_data'];
              documentID = element.id;
            }));
  }

  initCalendar(List list) async {
    await resultDoc().get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        list.add(doc.data());
      });
    });
  }

  createCalendar(List list, Map data) async {
    data[this.routine] = data[this.routine]?.toList();
    data['category'] = data['category']?.toList();
    await resultDoc().add({
      date: list,
      this.workoutData: data,
    });
  }

  updateCalendar(List list, Map data) async {
    Map map = {};
    storedData[this.routine] = storedData[this.routine]?.toSet();
    storedData['category'] = storedData['category']?.toSet();
    storedData.forEach((key, value) {
      int i = 0;
      data.forEach((k, d) {
        i++;
        if (key == k) {
          d.addAll(value);
          i = 0;
        }
        if (i == data.length) {
          map.addAll({key: value});
        }
      });
    });
    data.addAll(map);
    data[this.routine] = data[this.routine]?.toList();
    data['category'] = data['category']?.toList();
    await resultDoc().doc(documentID).update({
      date: list,
      this.workoutData: data,
    });
  }

  Map calendarDataToEvents(List list) {
    Map<DateTime, List<dynamic>> map = {};
    list.forEach((element) {
      map.addAll({
        DateTime(element[date][0], element[date][1], element[date][2]): [
          element[workoutData]
        ]
      });
    });
    return map;
  }

  deleteRoutine(int year, int month, int day) async {
    String documentID;
    await resultDoc()
        .where(date, isEqualTo: [year, month, day])
        .get()
        .then((value) => value.docs.forEach((element) {
              documentID = element.reference.id;
            }));
    resultDoc().doc(documentID).delete();
  }
}
