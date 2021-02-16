import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'lib_control/theme_control.dart';

import 'package:workout/calendar/calendar_control.dart';
import 'package:workout/daily_workout/MainPage.dart';
import 'package:workout/settings/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting().then((dynamic) => runApp(TestWidget()
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
      initialRoute: '/h',
      getPages: [
        GetPage(
          name: '/c',
          page: () => CalendarPage(
            title: 'Table Calendar Demo',
          ),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: '/h',
          page: () => MainPage(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: '/s',
          page: () => Settings(),
          transition: Transition.noTransition,
        ),
      ],
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


