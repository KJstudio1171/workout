import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

import 'package:workout/daily_workout/mainpage.dart';
import 'package:workout/lib_control/theme_control.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    if (_seen) {
      Get.off(() => MainPage());
    } else {
      await prefs.setBool('seen', true);
      Get.off(MainPage());
      Get.to(Intro(), fullscreenDialog: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    checkFirstSeen();
    return new Scaffold(
      body: new Center(
        child: new Text('Loading...'),
      ),
    );
  }
}

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  List<Widget> list = [
    Image.asset('images/guide1-kr.png'),
    Image.asset('images/guide2-kr.png'),
    Image.asset('images/guide3-kr.png'),
    Image.asset('images/guide4-kr.png'),
    Image.asset('images/guide5-kr.png'),
    Image.asset('images/guide6-kr.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color3,
      appBar: AppBar(
        backgroundColor: color1,
      ),
      body: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return list[index];
        },
        itemCount: 6,
        pagination: SwiperPagination(),
        control: SwiperControl(color: color1),
        outer: true,
      ),
    );
  }
}
