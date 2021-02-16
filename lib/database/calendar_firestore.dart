import 'package:flutter/material.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'package:workout/lib_control/theme_control.dart';
import 'package:workout/daily_workout/set_control.dart';
import 'package:workout/database/workout_firestore.dart';
import 'package:workout/database/map_structure.dart';

List<Map<String, dynamic>> routineData = [];

List<int> list = [2020, 2, 23];

Map<String, dynamic> calendarMap = {
  'routine': {'테스트', '다이나믹'},
  '팔씨름': ['9회'],
};

int chooseList = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  /*ChangeNotifierProvider(
          create: (context) => SimpleState(),
          child: StateLoginDemo(),*/
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: color1,
      ),
      home: FireStoreSelectedRoutine(),
    );
  }
}

class FireStoreSelectedRoutine extends StatefulWidget {
  FireStoreSelectedRoutine();

  @override
  _FireStoreSelectedRoutineState createState() =>
      _FireStoreSelectedRoutineState();
}

class _FireStoreSelectedRoutineState extends State<FireStoreSelectedRoutine> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // 컬렉션명
  final String identification = 'test_id00';

  // 필드명
  final String resultData = 'resultData';
  final String routine = 'routine';
  final String workoutData = 'workout_data';
  final String date = 'date';
  final String routineName = 'routine_name';
  AsyncSnapshot snapshots;
  var db;

  TextEditingController _newRoutineCon = TextEditingController();

  @override
  void initState() {
    db = routineDoc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "오늘의 운동",
          style: TextStyle(color: color8),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: RaisedButton(
              onPressed: () async {
                List list = [];
                await initCalendar(list);
                calendarDataToEvents(list);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: color2,
        label: Text('                    선택하기                     '),
        onPressed: () {
          createCalendar(list, calendarMap);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // Create Document
    );
  }

  @override
  void dispose() {
    super.dispose();
    _newRoutineCon.dispose();
    routineData.clear();
  }

  CollectionReference routineDoc() {
    return FirebaseFirestore.instance
        .collection(identification)
        .doc(resultData)
        .collection(resultData);
  }

  ///여기서부터 수정 함수들
  void createCalendar(List list, Map map) {
    map[this.routine] = map[this.routine].toList();
    db.add({
      date: list,
      this.workoutData: map,
    });
  }

  initCalendar(List list) async {
    await db.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc.data());
        list.add(doc.data());
      });
    });
  }

  calendarDataToEvents(List list) {
    Map map = {};
    list.forEach((element) {
      map.addAll({
        DateTime(element[date][0], element[date][1], element[date][2]):
            element[workoutData]
      });
    });
    print(map);
  }

  void deleteRoutine(int year, int month, int day) async{
    String documentID;
    await this.db
        .where(date, isEqualTo: [year, month, day])
        .get()
        .then((value) => value.docs.forEach((element) {
              documentID = element.reference.id;
            }));
    this.db.doc(documentID).delete();

  }

  void showCreateDoc() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("새로운 루틴 이름을 입력하세요"),
          content: Container(
            height: 200,
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(labelText: "루틴 이름"),
              controller: _newRoutineCon,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("취소"),
              onPressed: () {
                _newRoutineCon.clear();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("등록"),
              onPressed: () {
                if (_newRoutineCon.text != null) {}
                _newRoutineCon.clear();
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
