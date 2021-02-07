import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'lib_control/ui_size_control.dart';
import 'date_control.dart';
import 'workout_control.dart';
import 'lib_control/theme_control.dart';
import 'database/searchlist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'test.dart';
import 'set_control.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TestWidget()
      /*ChangeNotifierProvider(
          create: (context) => SimpleState(),
          child: StateLoginDemo(),*/
      );
}

class ButtonWidget extends StatefulWidget {
  //실효성이 의문
  ButtonWidget({this.iconn});

  dynamic iconn;

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(widget.iconn),
      onPressed: null,
      padding: EdgeInsets.all(UI_PADDING),
    );
  }
}

/*class DataSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final UI_WIDTH = MediaQuery.of(context).size.width;
    final UI_HEIGHT = MediaQuery.of(context).size.height;
    final UI_RATIO = MediaQuery.of(context).devicePixelRatio;
    final STATUSBARHEIGHT = MediaQuery.of(context).padding.top;
    Widget dataSection = Container(
      padding: EdgeInsets.all(UI_PADDING),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                child: Text("xxxx년 x월"),
                padding: EdgeInsets.fromLTRB(
                    UI_PADDING,
                    UI_HEIGHT * 0.05 - STATUSBARHEIGHT,
                    UI_WIDTH * 0.5,
                    UI_PADDING),
              ),
              Container(
                child: Text("xxxx년 x월"),
                padding: EdgeInsets.fromLTRB(
                    0,
                    UI_HEIGHT * 0.05 - STATUSBARHEIGHT,
                    UI_WIDTH * 0.5,
                    UI_PADDING),
              ),
            ],
          ),
          ButtonWidget(iconn: Icons.voice_chat_rounded),
          ButtonWidget(iconn: Icons.fifteen_mp)
        ],
      ),
    );
    return dataSection;
  }
}
     */

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  var currentWidget = [
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DateSection(),
        WorkOutSection(),
      ],
    ),
    DateSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "xxxx년 x월",
          style: TextStyle(
            color: Color.fromARGB(255, 80, 97, 125),
          ),
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
              ButtonWidget(
                iconn: Icons.voice_chat_rounded,
              ),
              ButtonWidget(iconn: Icons.fifteen_mp),
            ],
          ),
        ],
      ),
      body: currentWidget[_index],
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

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
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
      routes: {
        '/M': (context) => MainPage(),
        '/L': (context) => SearchWorkoutPage(),
        '/I': (context) => Info(),
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
      },
      initialRoute: '/M',
    );
  }
}
