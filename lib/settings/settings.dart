import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:workout/lib_control/theme_control.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: Text('june1171'),
          ),
          ListTile(
            title: Text('연결된계정'),
          ),
          ListTile(
            title: Text('공지사항'),
          ),
          ListTile(
            title: Text('문의하기'),
          ),
          ListTile(
            title: Text('개발자에게 커피한잔'),
          ),
          ListTile(
            title: Text('리뷰를 남겨주세요'),
          ),
          ListTile(
            title: Text('개인정보 처리방침'),
          ),
          ListTile(
            title: Text('버전정보'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (index == 0) Get.offNamed('/c');
            if (index == 1) Get.back();
          },
          currentIndex: 2,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_today_outlined,
                color: color2,
              ),
              activeIcon: Icon(
                Icons.calendar_today_outlined,
                color: color7,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.mode_edit,
                  color: color2,
                ),
                activeIcon: Icon(
                  Icons.mode_edit,
                  color: color7,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.inbox,
                  color: color2,
                ),
                activeIcon: Icon(
                  Icons.inbox,
                  color: color7,
                ),
                label: ''),
          ]),
    );
  }
}
