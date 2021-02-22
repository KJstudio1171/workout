import 'package:flutter/material.dart';

import 'package:group_button/group_button.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:workout/lib_control/theme_control.dart';

List<dynamic> workoutList = [];
List<String> cateButtonList = [
  '전체',
  '유산소',
  '가슴',
  '어깨',
  '등',
  '이두',
  '삼두',
  '복부',
  '다리',
  '기타'
];
int chooseList = 0;
String undCateCon = '이두';

class IconButtonNeumorphic extends StatefulWidget {
  IconButtonNeumorphic(this._document);

  var _document;

  @override
  _IconButtonNeumorphicState createState() => _IconButtonNeumorphicState();
}

class _IconButtonNeumorphicState extends State<IconButtonNeumorphic> {
  bool _pressIcon = false;

  final String wkoName = "운동 이름";
  final String wkoCategory = "운동 부위";

  List<String> workoutData = [];

  @override
  void initState() {
    workoutData = [widget._document[wkoName],widget._document[wkoCategory]];
    super.initState();
  }

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
              workoutList
                  .add(workoutData);
              print(workoutList);
            } else {
              workoutList
                  .remove(workoutData);
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
    );
  }
}

class FireStoreSelectWorkout extends StatefulWidget {

  @override
  _FireStoreSelectWorkoutState createState() => _FireStoreSelectWorkoutState();
}

class _FireStoreSelectWorkoutState extends State<FireStoreSelectWorkout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // 컬렉션명
  final String identification = 'test_id00';
  final String classification = 'selectWorkout';

  // 필드명
  final String wkoName = "운동 이름";
  final String wkoCategory = "운동 부위";
  final String wkoDatetime = "datetime";
  final String wkoMemo = '메모';
  final String wkoUrl = 'URL';
  AsyncSnapshot snapshots;
  var db, stream;

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
          style: TextStyle(color: color8),
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
                    '운동을 추가하세요',
                    style: TextStyle(color: color8, fontSize: 15),
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
                        stream = fireStoreDoc().where(wkoCategory,
                            isEqualTo: cateButtonList[chooseList]);
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
                        Timestamp ts = document[wkoDatetime];
                        String dt = timestampToStrDateTime(ts);
                        return Card(
                          elevation: 2,
                          child: Row(
                            children: [
                              InkWell(
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
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  width: 350,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            document[wkoName],
                                            style: TextStyle(
                                              color: color12,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          document[wkoCategory],
                                          style: TextStyle(color: colorBlack54),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              IconButtonNeumorphic(document),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
              }
            },
          ),
        ],
      ),
      // Create Document
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: color7,
        label: Text('                    선택하기                     '),
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
    super.dispose();
    _newNameCon.dispose();
    _newCateCon.dispose();
    _newMemoCon.dispose();
    _undNameCon.dispose();
    _undCateCon.dispose();
    _undMemoCon.dispose();
    editingCon.dispose();
  }

  CollectionReference fireStoreDoc() {
    return FirebaseFirestore.instance
        .collection(this.identification)
        .doc(this.classification)
        .collection(this.classification);
  }

  void initWorkout() {
    Map<String, List> workMap = {
      '유산소': [
        '걷기',
        '런닝',
        '로잉',
        '마운틴 클라이머',
        '사이클',
        '스태퍼',
        '점핑잭',
        '줄넘기',
        '버피 테스트',
      ],
      '가슴': [
        '푸시업',
        '딥스',
        '플라이',
        '풀오버',
        '벤치 프레스',
        '인클라인 벤치 프레스',
        '디클라인 벤치 프레스',
        '체스트 프레스',
        '크로스 오버',
      ],
      '어깨': [
        'Y-레이즈',
        '플레이트 프레스',
        '숄더 프레스',
        '밀리터리 프레스',
        '비하인드 넥 프레스',
        '프런트 레이즈',
        '레터럴 레이즈',
        '벤트오버 레터럴 레이즈',
        '슈럭',
        '업라이트 로우',
        '리버스 플라이',
      ],
      '등': [
        '로우',
        '데드 리프트',
        '풀업',
        '풀오버'
            '랫 풀다운',
      ],
      '이두': [
        'EZ-바 컬',
        '바벨 컬',
        '덤벨 컬',
        '해머컬',
        '케이블 컬',
      ],
      '삼두': [
        '트라이셉스 익스텐션',
        '킥백'
            '트라이셉스 프레스 다운'
      ],
      '복부': [
        'L-시트',
        '러시안 트위스트',
        '레그 레이즈',
        '롤 아웃',
        'V-업',
        '사이드 밴드',
        '싯업',
        '에어 바이크',
        '크런치',
        '플랭크',
        '행잉 레그 레이즈'
      ],
      '다리': [
        '스쿼트',
        '하이박스 점프',
        '런지',
        '카프 레이즈',
        '힙 레이즈',
        '스텝업',
      ]
    };
    workMap.forEach((key, value) {
      value.forEach((element) {
        createWorkout(element, key,
            url: 'https://www.youtube.com/results?search_query=$element');
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
  void readWorkout(String documentID) {
    fireStoreDoc().doc(documentID).get().then((DocumentSnapshot doc) {
      showReadDoc(doc);
    });
  }

  // 문서 갱신 (Update)
  void updateWorkout(String docID, String name, String category,
      {String url = '', String memo = ''}) {
    fireStoreDoc().doc(docID).update({
      wkoName: name,
      wkoCategory: category,
      wkoUrl: url,
      wkoMemo: memo,
    });
  }

  // 문서 삭제 (Delete)
  void deleteWorkout(String docID) {
    fireStoreDoc().doc(docID).delete();
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
                _newMemoCon.clear();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("등록"),
              onPressed: () {
                if (_newCateCon.text.isNotEmpty &&
                    _newNameCon.text.isNotEmpty) {
                  createWorkout(_newNameCon.text, _newCateCon.text);
                }
                _newNameCon.clear();
                _newCateCon.clear();
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
                  Text.rich(TextSpan(
                    children: [
                      TextSpan(
                        text: '$wkoCategory: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      TextSpan(
                        text: '${doc.data()[wkoCategory]}'
                      ),
                    ]
                  )),
                  SizedBox(height: 20,),
                  Text('$wkoUrl:',style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),),
                  InkWell(
                    enableFeedback: false,
                    onTap: () async {
                      await launch(url,
                          forceWebView: true, forceSafariVC: true);
                    },
                    child: Text(
                      "${doc.data()[wkoUrl] ?? '없음'}",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text('$wkoMemo: ',
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
                  decoration: InputDecoration(labelText: wkoName),
                  controller: _undNameCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: wkoCategory),
                  controller: _undCateCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: wkoUrl),
                  controller: _undUrlCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: wkoMemo),
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
                      memo: _undMemoCon.text);
                }
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("삭제"),
              onPressed: () {
                deleteWorkout(doc.id);
                Navigator.pop(context);
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
