import 'package:flutter/material.dart';

import 'package:group_button/group_button.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:workout/lib_control/theme_control.dart';
import 'package:workout/database/workout_database.dart';

List<dynamic> workoutList = [];

Map pressed = {};
int chooseList = 0;
String undCateCon = '이두';

class IconButtonNeumorphic extends StatefulWidget {
  IconButtonNeumorphic(this.workoutData, {Key key}) : super(key: key);

  List<String> workoutData;

  @override
  _IconButtonNeumorphicState createState() => _IconButtonNeumorphicState();
}

class _IconButtonNeumorphicState extends State<IconButtonNeumorphic> {
  bool _pressIcon;

  final String wkoName = "wko_name";
  final String wkoCategory = "wko_category";

  @override
  void initState() {
    _pressIcon = pressed[widget.key];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          width: 40,
          height: 40,
          child: InkWell(
            enableFeedback: false,
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              pressed[widget.key] = !pressed[widget.key];
              setState(() {
                _pressIcon = !_pressIcon;
                if (_pressIcon) {
                  workoutList.add(widget.workoutData);
                  print(workoutList);
                } else {
                  workoutList.remove(widget.workoutData);
                  print(workoutList);
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
                      color: color7,
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
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: 70, maxWidth: 300),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  widget.workoutData[0],
                  style: TextStyle(
                    color: _pressIcon ? color7 : color12,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: 70, maxWidth: 300),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  widget.workoutData[1],
                  style: TextStyle(color: colorBlack54),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class FireStoreSelectWorkout extends StatefulWidget {
  @override
  _FireStoreSelectWorkoutState createState() => _FireStoreSelectWorkoutState();
}

class _FireStoreSelectWorkoutState extends State<FireStoreSelectWorkout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final String classification = 'selectWorkout';

  // 필드명
  final String wkoName = "wko_name";
  final String wkoCategory = "wko_category";
  final String wkoDatetime = "datetime";
  final String wkoMemo = 'memo';
  final String wkoUrl = 'URL';
  AsyncSnapshot snapshots;
  var db, stream;
  List<Widget> viewport = [];

  TextEditingController _newNameCon = TextEditingController();
  TextEditingController _newCateCon = TextEditingController();
  TextEditingController _newUrlCon = TextEditingController();
  TextEditingController _newMemoCon = TextEditingController();
  TextEditingController _undNameCon = TextEditingController();
  TextEditingController _undCateCon = TextEditingController();
  TextEditingController _undUrlCon = TextEditingController();
  TextEditingController _undMemoCon = TextEditingController();
  TextEditingController editingCon = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sizeCheck();
    db = fireStoreDoc();
    stream = fireStoreDoc().orderBy(wkoName);
  }

  sizeCheck() async {
    var tx = await fireStoreDoc().get().then((value) => value.size);
    if (tx == 0) {
      initWorkout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: color1,
        title: Text(
          "운동 목록",
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(8),
            child: InkWell(
              onTap: showCreateDoc,
              enableFeedback: false,
              highlightColor: color1,
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: color8,
                    size: 19,
                  ),
                  Text(
                    '운동 생성하기',
                    style: TextStyle(
                      fontFamily: 'godo',
                      color: color8,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(5, 15, 5, 10),
            height: 60,
            child: TextField(
              cursorColor: color1,
              onChanged: (value) {
                if (value.trim().isNotEmpty) {
                  setState(() {
                    stream = fireStoreDoc()
                        .where(wkoName, isGreaterThanOrEqualTo: value.trim())
                        .where(wkoName,
                            isLessThanOrEqualTo: value.trim() + '힣');
                  });
                } else {
                  setState(() {
                    stream = fireStoreDoc().orderBy(wkoName);
                  });
                }
              },
              controller: editingCon,
              decoration: InputDecoration(
                fillColor: color1,
                labelText: "운동 이름",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: new BoxConstraints(
              minHeight: 0,
              maxHeight: 50,
            ),
            child: ListView(
              padding: EdgeInsets.only(left: 5),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                GroupButton(
                  isRadio: true,
                  spacing: 5,
                  buttons: cateButtonList,
                  onSelected: (index, isSelected) {
                    chooseList = index;
                    if (chooseList != 0) {
                      setState(() {
                        if (cateButtonList[chooseList] == '기타') {
                          List list = List.from(cateButtonList);
                          list.removeLast();
                          stream = fireStoreDoc()
                              .where(wkoCategory, whereNotIn: list);
                        } else {
                          stream = fireStoreDoc().where(wkoCategory,
                              isEqualTo: cateButtonList[chooseList]);
                        }
                      });
                    } else {
                      setState(() {
                        stream = fireStoreDoc().orderBy(wkoName);
                      });
                    }
                  },
                  selectedColor: color1,
                  unselectedShadow: [BoxShadow(color: Colors.transparent)],
                  selectedButtons: null,
                )
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: stream.snapshots(),
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
                      shrinkWrap: true,
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        List<String> workoutData = [
                          document[wkoName],
                          document[wkoCategory]
                        ];
                        IconButtonNeumorphic checkCircle =
                            IconButtonNeumorphic(workoutData, key: UniqueKey());
                        pressed[checkCircle.key] = false;
                        Timestamp ts = document[wkoDatetime];
                        String dt = timestampToStrDateTime(ts);
                        return Card(
                          elevation: 2,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              checkCircle,
                              Container(
                                height: 60,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                width: 30,
                                height: 30,
                                child: InkWell(
                                  // Read Document
                                  enableFeedback: false,
                                  onTap: () {
                                    final String documentID = document.id;
                                    readWorkout(documentID);
                                    print('$documentID');
                                  },
                                  // Update or Delete Document
                                  onLongPress: () {
                                    showUpdateOrDeleteDoc(document);
                                  },
                                  child: Center(
                                    child: Text(
                                      'i',
                                      style: TextStyle(
                                          fontSize: 20, fontFamily: 'godo'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
              }
            },
          ),
          Container(
            height: 80,
          )
        ],
      ),
      // Create Document
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: color7,
        label: Text(
          '                    선택하기                     ',
          style: TextStyle(fontFamily: 'godo'),
        ),
        onPressed: () {
          if (workoutList.isEmpty) {
            Get.defaultDialog(title: '운동없음', middleText: '운동을 선택해주세요.');
          } else {
            Get.back(result: workoutList);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void dispose() {
    workoutList.clear();
    pressed.clear();
    super.dispose();
    _newNameCon.dispose();
    _newCateCon.dispose();
    _newUrlCon.dispose();
    _newMemoCon.dispose();
    _undNameCon.dispose();
    _undCateCon.dispose();
    _undUrlCon.dispose();
    _undMemoCon.dispose();
    editingCon.dispose();
  }

  CollectionReference fireStoreDoc() {
    String identification = FirebaseAuth.instance.currentUser.uid;

    return FirebaseFirestore.instance
        .collection(identification)
        .doc(this.classification)
        .collection(this.classification);
  }

  void initWorkout() {
    workoutMap.forEach((key, value) {
      value.forEach((element) {
        createWorkout(element, key,
            url: 'https://www.youtube.com/results?search_query=운동+$element');
      });
    });
  }

  ///여기서부터 수정 함수들
  void createWorkout(String name, String category,
      {String url = '', String memo = ''}) {
    fireStoreDoc().add({
      wkoName: name,
      wkoCategory: category,
      wkoUrl: url,
      wkoMemo: memo,
      wkoDatetime: Timestamp.now(),
    });
  }

  // 문서 조회 (Read)
  void readWorkout(String documentID) async {
    await fireStoreDoc().doc(documentID).get().then((DocumentSnapshot doc) {
      showReadDoc(doc);
    });
  }

  // 문서 갱신 (Update)
  void updateWorkout(String docID, String name, String category,
      {String url = '', String memo = ''}) async {
    await fireStoreDoc().doc(docID).update({
      wkoName: name,
      wkoCategory: category,
      wkoUrl: url,
      wkoMemo: memo,
    });
  }

  // 문서 삭제 (Delete)
  void deleteWorkout(String docID) async {
    await fireStoreDoc().doc(docID).delete();
  }

  void showCreateDoc() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("새로운 운동을 등록하세요!"),
          content: Container(
            height: 250,
            child: Column(
              children: <Widget>[
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: "운동 이름"),
                  controller: _newNameCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "운동 부위"),
                  controller: _newCateCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "URL"),
                  controller: _newUrlCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "메모"),
                  controller: _newMemoCon,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("취소"),
              onPressed: () {
                _newNameCon.clear();
                _newCateCon.clear();
                _newUrlCon.clear();
                _newMemoCon.clear();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("등록"),
              onPressed: () {
                if (_newNameCon.text.isNotEmpty &&
                    _newNameCon.text.length <= 100 &&
                    _newCateCon.text.length <= 100 &&
                    _newUrlCon.text.length <= 1000 &&
                    _newMemoCon.text.length <= 5000) {
                  createWorkout(_newNameCon.text, _newCateCon.text,
                      url: _newUrlCon.text, memo: _newMemoCon.text);
                }
                _newNameCon.clear();
                _newCateCon.clear();
                _newUrlCon.clear();
                _newMemoCon.clear();
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void showReadDoc(DocumentSnapshot doc) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        String url = Uri.encodeFull(doc.data()[wkoUrl]);
        return AlertDialog(
          title: Text(
            '${doc.data()[wkoName]}',
            style: TextStyle(color: color10),
          ),
          content: Container(
            height: 200,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: '운동 부위: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    TextSpan(text: '${doc.data()[wkoCategory]}'),
                  ])),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'URL:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    enableFeedback: false,
                    onTap: () async {
                      await launch(url,
                          forceWebView: false, forceSafariVC: false);
                    },
                    child: Text(
                      "${doc.data()[wkoUrl] ?? '없음'}",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('메모: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  Text('${doc.data()[wkoMemo] ?? '없음'}'),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                showUpdateOrDeleteDoc(doc);
              },
              child: Text("수정"),
            ),
            FlatButton(
              child: Text("확인"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    /*_scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: color11,
          duration: Duration(seconds: 3),
          content: Text(
              "$wkoName: ${doc.data()[wkoName]}\n$wkoCategory: ${doc.data()[wkoCategory]}"
              "\n$wkoMemo: ${doc.data()[wkoMemo]}"),
          action: SnackBarAction(
            label: "완료",
            textColor: colorWhite,
            onPressed: () {},
          ),
        ),
      );*/
  }

  void showUpdateOrDeleteDoc(DocumentSnapshot doc) {
    _undNameCon.text = doc[wkoName];
    _undCateCon.text = doc[wkoCategory];
    _undUrlCon.text = doc[wkoUrl];
    _undMemoCon.text = doc[wkoMemo];
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("운동을 수정하실 건가요?"),
          content: Container(
            height: 250,
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: '운동 이름'),
                  controller: _undNameCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: '운동 부위'),
                  controller: _undCateCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'URL'),
                  controller: _undUrlCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: '메모'),
                  controller: _undMemoCon,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("취소"),
              onPressed: () {
                _undNameCon.clear();
                _undCateCon.clear();
                _undUrlCon.clear();
                _undMemoCon.clear();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("수정"),
              onPressed: () {
                if (_undNameCon.text.isNotEmpty &&
                    _undCateCon.text.isNotEmpty) {
                  updateWorkout(doc.id, _undNameCon.text, _undCateCon.text,
                      url: _undUrlCon.text, memo: _undMemoCon.text);
                }
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("삭제"),
              onPressed: () {
                Get.defaultDialog(
                  title: '삭제',
                  middleText: '정말 삭제하시겠습니까?',
                  textCancel: '취소',
                  textConfirm: '확인',
                  confirmTextColor: color8,
                  onConfirm: () {
                    deleteWorkout(doc.id);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                );
              },
            )
          ],
        );
      },
    );
  }

  String timestampToStrDateTime(Timestamp ts) {
    return DateTime.fromMicrosecondsSinceEpoch(ts.microsecondsSinceEpoch)
        .toString();
  }
}
