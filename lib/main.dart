import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:workout/database/mapstructure.dart';

import 'lib_control/ui_size_control.dart';
import 'lib_control/theme_control.dart';

import 'package:workout/daily_workout/date_control.dart';
import 'package:workout/daily_workout/workout_control.dart';
import 'package:workout/daily_workout/set_control.dart';
import 'package:workout/calendar/calendar_control.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting().then((dynamic) =>
      runApp(TestWidget()
        /*ChangeNotifierProvider(
          create: (context) => SimpleState(),
          child: StateLoginDemo(),*/
      ));
}

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //double width = MediaQuery.of(context).size.width;
    return GetMaterialApp(
      title: 'MainPage',
      theme: ThemeContol.firstDesign,
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      //rootnavigator false 페이지 유지가능 Navigator.of(context, rootNavigator: false).pushNamed("/route");
      // Get.to(page,{argument,transition})
      //Get.argument
      //Get.back
      // async{
      // final data = await Get.to()}
      //Get.back(result:)
      //getPages:[
      // GetPage(
      // name:,
      // page:()=>]
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 1;
  DateTime dateTime = DateTime.now();
  List<Widget> selectedWidget;

  @override
  void initState() {
    selectedWidget = [
      MyHomePage(title: 'Table Calendar Demo'),
      WorkOutSection(dateTime),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${dateTime.year}년 ${dateTime.month}월",
                style: TextStyle(
                  color: Color.fromARGB(255, 80, 97, 125),
                ),
              ),
              Icon(Icons.arrow_drop_down_sharp, color: Colors.blueGrey,),
            ],
          ),
          onTap: () {
            Future<DateTime> selected = showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2015),
                lastDate: DateTime(2025),
                builder: (BuildContext context, Widget child) {
                  return Theme(data: ThemeData.light(), child: child);
                });
            selected.then((selected) {
              setState(() {
                dateTime = selected;
                selectedWidget = [
                  MyHomePage(title: 'Table Calendar Demo'),
                  WorkOutSection(dateTime),
                ];
              });
            });
          },
        ),
        bottom: PreferredSize(
          child: Container(
            color: Color.fromARGB(255, 224, 224, 224),
            height: 1.0,
          ),
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        actions: [
          Row(
            children: [
              IconButton(icon: Icon(Icons.home), onPressed: null),
            ],
          ),
        ],
      ),
      body: selectedWidget[_index],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          currentIndex: _index,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          ]),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('                    저장하기                     '),
        onPressed: () {
          WorkoutSaveData.initData();
          WorkoutSaveData.dataVisualizing();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
