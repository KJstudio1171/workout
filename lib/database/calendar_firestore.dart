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
Map<String,dynamic> calendarMap = {
  'routine':{'테스트','다이나믹'},
  'date':[2021,2,23],
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
  final String routineName = 'routine_name';
  final String wkoCategory = 'wko_category';
  final String set = "set";
  final String weight = 'weight';
  final String reps = 'reps';
  final String time = "time";
  final String unitWeight = 'unit_weight';
  final String unitTime = 'unit_time';
  final String datetime = 'datetime';
  AsyncSnapshot snapshots;
  var db;

  TextEditingController _newRoutineCon = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = routineDoc().orderBy(routineName);
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
          InkWell(
            enableFeedback: true,
            child: ListTile(
              title: Text('루틴없이 운동하기'),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
              onTap: () {},
            ),
          ),
          /*StreamBuilder<QuerySnapshot>(
            stream: db.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text("Error: ${snapshot.error}");
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Text("Loading...");
                default:
                  return Expanded(
                    child: ListView(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      children:
                      snapshot.data.docs.map((DocumentSnapshot document) {
                        Map structure = document['wko_category'];
                        List wkoCategory = [];
                        structure.forEach((key, value) {
                          wkoCategory.add(key.toString());
                        });
                        return Dismissible(
                          child: ExpansionTile(
                            maintainState: true,
                            title: Text(
                              document['routine_name'],
                              style: TextStyle(
                                color: color12,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            leading: IconButtonNeumorphic(document),
                            children: [
                              ListView.builder(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: wkoCategory.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String wkoName = wkoCategory[index];
                                    List wkoSetList = structure[wkoName];
                                    return Dismissible(
                                      child: ExpansionTile(
                                        maintainState: true,
                                        title: Text(wkoName),
                                        children: [
                                          ListView.builder(
                                            physics: ScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: EdgeInsets.fromLTRB(
                                                20, 5, 20, 20),
                                            itemBuilder: (context, index) {
                                              return Dismissible(
                                                key: UniqueKey(),
                                                child: ListTile(
                                                  title: textChanger(
                                                      wkoSetList, index),
                                                ),
                                                onDismissed: (DismissDirection
                                                direction) {
                                                  deleteSet(
                                                      document, wkoName, index);
                                                },
                                                secondaryBackground: Container(
                                                  child: Center(
                                                    child: Text(
                                                      '삭제',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  color: color11,
                                                ),
                                                background: Container(),
                                                direction:
                                                DismissDirection.endToStart,
                                              );
                                            },
                                            itemCount: wkoSetList.length,
                                          ),
                                          InkWell(
                                              enableFeedback: true,
                                              onTap: () async {
                                                List result =
                                                await Get.to(Info());
                                                createSet(
                                                    document, wkoName, result);
                                                print(result.toString());
                                              },
                                              child: ListTile(
                                                leading: Icon(Icons.add),
                                                title: Text('SET 추가하기'),
                                              )),
                                        ],
                                      ),
                                      key: UniqueKey(),
                                      onDismissed:
                                          (DismissDirection direction) {
                                        deleteWorkout(document, wkoName);
                                      },
                                      secondaryBackground: Container(
                                        child: Center(
                                          child: Text(
                                            '삭제',
                                            style:
                                            TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        color: color11,
                                      ),
                                      background: Container(),
                                      direction: DismissDirection.endToStart,
                                    );
                                  }),
                              InkWell(
                                  enableFeedback: true,
                                  onTap: () async {
                                    Map<String, dynamic> map =
                                    document[this.wkoCategory];
                                    List result =
                                    await Get.to(FireStoreSelectWorkout());
                                    result.forEach((e) {
                                      // print(map.toString());
                                      map[e] = [];
                                      print(map.toString());
                                    });
                                    createWorkout(document, map);
                                  },
                                  child: ListTile(
                                    leading: Icon(Icons.add),
                                    title: Text('운동 추가하기'),
                                  )),
                            ],
                          ),
                          key: UniqueKey(),
                          onDismissed: (DismissDirection direction) {
                            deleteRoutine(document.id);
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
                        );
                      }).toList(),
                    ),
                  );
              }
            },
          ),*/
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: color2,
        label: Text('                    선택하기                     '),
        onPressed: () {
          createCalendar(calendarMap);
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

  Widget textChanger(List wkoSetList, int index) {
    if (wkoSetList[index][weight] == '') {
      if (wkoSetList[index][reps] == '') {
        return Row(
          children: [
            Text(wkoSetList[index][time] + wkoSetList[index][unitTime]),
            Text(wkoSetList[index][set] + 'set'),
          ],
        );
      } else {
        return Row(
          children: [
            Text(wkoSetList[index][reps] + '회'),
            Text(wkoSetList[index][set] + 'set'),
          ],
        );
      }
    } else {
      if (wkoSetList[index][reps] == '') {
        return Row(
          children: [
            Text(wkoSetList[index][weight] + wkoSetList[index][unitWeight]),
            Text(wkoSetList[index][time] + wkoSetList[index][unitTime]),
            Text(wkoSetList[index][set] + 'set'),
          ],
        );
      } else {
        return Row(
          children: [
            Text(wkoSetList[index][weight] + wkoSetList[index][unitWeight]),
            Text(wkoSetList[index][reps] + '회'),
            Text(wkoSetList[index][set] + 'set'),
          ],
        );
      }
    }
  }

  CollectionReference routineDoc() {
    return FirebaseFirestore.instance
        .collection(identification)
        .doc(resultData)
        .collection(resultData);
  }

  void initWorkout() {}

  ///여기서부터 수정 함수들
  void createCalendar(Map map) {
    map[this.routine]=map[this.routine].toList();
    routineDoc().add(map);
  }

  void deleteRoutine(String docID) {
    routineDoc().doc(docID).delete();
  }

  void deleteWorkout(DocumentSnapshot document, String wkoName) {
    Map<String, dynamic> map = document[wkoCategory];
    if (map.containsKey(wkoName)) {
      map.remove(wkoName);
      routineDoc().doc(document.id).update({wkoCategory: map});
    }
  }

  void deleteSet(DocumentSnapshot document, String wkoName, int index) {
    Map<String, dynamic> map = document[wkoCategory];
    List list = document[wkoCategory][wkoName];
    list.removeAt(index);
    map.remove(wkoName);
    map.addAll({wkoName: list});
    routineDoc().doc(document.id).update({wkoCategory: map});
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
                if (_newRoutineCon.text != null) {
                }
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

class IconButtonNeumorphic extends StatefulWidget {
  IconButtonNeumorphic(this._document);

  DocumentSnapshot _document;

  @override
  _IconButtonNeumorphicState createState() => _IconButtonNeumorphicState();
}

class _IconButtonNeumorphicState extends State<IconButtonNeumorphic> {
  bool _pressIcon = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      width: 40,
      height: 40,
      child: InkWell(
        enableFeedback: false,
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          setState(() {
            _pressIcon = !_pressIcon;
            if (_pressIcon) {
              routineData.add(widget._document.data());
            } else {
              print(routineData.toString());
              routineData.removeWhere((element) =>
              element['routine_name'] ==
                  widget._document.data()['routine_name']);
            }
          });
        },
        child: Neumorphic(
          style: _pressIcon
              ? NeumorphicStyle(
            shape: NeumorphicShape.flat,
            intensity: 1.0,
            boxShape: NeumorphicBoxShape.circle(),
            lightSource: LightSource.topLeft,
            depth: -2,
            color: color2,
          )
              : NeumorphicStyle(
            shape: NeumorphicShape.flat,
            intensity: 1.0,
            boxShape: NeumorphicBoxShape.circle(),
            lightSource: LightSource.topLeft,
            depth: 0,
            color: Colors.grey[200],
          ),
          child: Icon(
            _pressIcon ? Icons.check : Icons.add,
            color: _pressIcon ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}