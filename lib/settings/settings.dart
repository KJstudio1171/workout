import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:workout/lib_control/theme_control.dart';
import 'package:workout/login_page/splash.dart';
import 'package:workout/settings/settings.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        backgroundColor: color1,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('연결된계정'),
            trailing: Text(FirebaseAuth.instance.currentUser.displayName),
          ),
          ListTile(
            title: Text('버전정보'),
            trailing: Text('1.0.0'),
          ),
          InkWell(
            enableFeedback: false,
            onTap: () {
              Get.to(
                notice(),
                fullscreenDialog: true,
              );
            },
            child: ListTile(
              title: Text('공지사항'),
            ),
          ),
          InkWell(
            enableFeedback: false,
            onTap: () {
              final Uri emailScheme = Uri(
                  scheme: 'mailto',
                  path: 'eddyfunfun@gmail.com',
                  queryParameters: {'subject': '문의사항&건의사항'});
              launch(emailScheme.toString());
            },
            child: ListTile(
              title: Text('문의하기'),
            ),
          ),
          InkWell(
            enableFeedback: false,
            onTap: () {
              Get.to(
                Intro(),
                fullscreenDialog: true,
              );
            },
            child: ListTile(
              title: Text('도움말'),
            ),
          ),
          InkWell(
            enableFeedback: false,
            onTap: () {
              Get.defaultDialog(
                  title: '커피한잔...', middleText: '신한은행 110-445-903961');
            },
            child: ListTile(
              title: Text('개발자에게 커피한잔'),
            ),
          ),
          ListTile(
            title: Text('리뷰를 남겨주세요'),
          ),
          InkWell(
            enableFeedback: false,
            onTap: () {
              Get.to(policy(), fullscreenDialog: true);
            },
            child: ListTile(
              title: Text('개인정보 처리방침'),
            ),
          ),
          InkWell(
            enableFeedback: false,
            child: ListTile(
              title: Text('로그아웃'),
              onTap: () {
                Get.defaultDialog(
                    title: '로그아웃',
                    middleText: '정말 로그아웃 하시겠습니까?',
                    textCancel: '취소',
                    textConfirm: '확인',
                    onConfirm: () {
                      FirebaseAuth.instance.signOut();
                    },
                    confirmTextColor: color8);
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
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

  Scaffold notice() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
      ),
      body: ListView(
        children: [
          ExpansionTile(
            title: Text('버전 1.0.0'),
            children: [
              Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(border: Border.all(color: color1)),
                child: Text('안녕하세요.'
                    '\n\n'
                    '하루운동을 다운 받아주셔서 정말 감사합니다.'
                    '\n\n'
                    '1.0.0 버전은 초기 출시 베타버전으로 예상치 못한 오류가 있을 수 있으며 기능이 다소 빈약할 수 있습니다.'
                    '\n\n'
                    '오류가 있는 부분이나 개선하면 좋을 것 같은 부분을 메일로 보내주시면 감사하겠습니다.'
                    '\n\n'
                    'gmail을 이용하실 경우 문의 하기 버튼을 누르시면 바로 보내실 수 있으며,'
                    '이외의 경우에는 eddyfunfun@gmail.com으로 보내주시면 됩니다.'
                    '\n'),
              )
            ],
          ),
        ],
      ),
    );
  }

  Scaffold policy() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(border: Border.all(color: color1)),
            child: Text('개인정보처리방침'
                '\n\n'
                '\'\'하루운동\'\'(이하 \'\'앱\'\')은 개인정보에 관한 권리를 보호하기 위해 최선을  다하고 있습니다. '
                '본 개인정보 보호정책(이하 \'\'본정책\'\')은 귀하가 제공하거나 당사가 수집하는 정보(개인정보 포함)를 '
                '수집, 저장, 이용, 관리하는 방법에 관한 것입니다. 서비스를 이용함으로써, 귀하는 본 정책 및 본 정책에 규정된 '
                '방식에 따른 데이터(개인정보 포함) 처리에 동의하는 것으로 간주됩니다. 귀하가 이러한 약관에 동의하지 않는 경우, '
                '서비스를 이용하지 마시기 바랍니다.'
                '앱은 개인정보 취급 방침을 통하여 귀하가 당사 서비스를 이용할 때 제공하는 개인정보가 어떠한 용도와 방식으로 이용되고 '
                '있으며, 개인정보 보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다.'
                '\n\n\n'
                '1.개인정보의 처리목적'
                '\n\n\n'
                '1)firebase'
                '\n\n'
                '앱을 사용하는 동안 일부 비 개인적인 정보가 수집 될 수 있습니다. 비 개인정보는 사용자를 식별 할 수 없는 익명의 정보로, '
                '앱 개선과 같은 통계적, 분석적 정보 및 연구 목적으로 수집됩니다. '
                'Google firebase 개인정보 취급 방침은 다음에서 찾을 수 있습니다.'
                'https://firebase.google.com/terms/data-processing-terms'
                '\n\n'
                '2)AdMob'
                '\n\n'
                '우리 앱을 통해 광고를 클릭하면 광고주는 쿠키 및 기타 웹 추적 기술을 사용하여 데이터를 수집 할 수 있습니다. '
                '일부 정보는 개인정보 일 수 있으며, 일부 정보는 비 개인정보 일 수 있습니다. 사용하기 전에 상호 작용하는 광고주의 이용'
                ' 약관 및 개인 정보 취급 방침을 검토하는 것이 좋습니다. '
                'Google의 광고 네트워크 개인 정보 보호 정책 목록은 다음에서 찾을 수 있습니다.'
                'https://www.google.com/policies/privacy/'
                '\n\n'
                '3) 페이스북 로그인, 구글플러스에의 연동'
                '\n\n'
                '귀하는 페이스북 로그인(Facebook Login), 구글 플러스(Google+) 제공자 같은 사이트(이하 \'\'SNS\'\') 등을 통하여 '
                '앱 서비스에 접속할 수 있습니다. 이러한 서비스들은 귀하가 본인임을 확인하여 귀하의 이름, 이메일 주소 같은 '
                '특정 개인 정보를 따로 기입하지 않고 앱 회원으로 가입할 수 있도록 하는 공유 옵션을 제공합니다. 앱은 해당 SNS의 정책과 약관에'
                '따라 SNS 서비스를 통하여 정보를 수집할 수 있습니다. 이때 앱이 수집할 수 있는 정보에는 다음과 같은 정보가 포함됩니다.'
                '(1) 성명 (2) SNS 상의 이용자 식별번호와 이용자명, (3) 이메일 주소, (4) 프로필 사진 또는 그 URL. 앱은 Facebook, Google+의'
                ' 패스워드를 수집하지 않습니다.'
                '\n\n\n'
                '2.개인정보 수집방법'
                '\n\n\n'
                '앱은 다음과 같은 방법으로 개인정보를 수집합니다. '
                '앱 프로그램의 실행 또는 사용 과정에서의 수집, '
                '협력회사로부터 제공(Facebook, Google+)'
                '\n\n\n'
                '3.개인정보의 처리 및 보유기간'
                '\n\n\n'
                '1) 개발자는 법령에 따른 개인정보 보유, 이용기간 또는 정보주체로부터 개인정보를 수집시에 동의 받은 개인정보 보유, 이용기간 내에서'
                ' 개인정보를 처리, 보유합니다.'
                '\n\n'
                '2) 각각의 개인정보 처리 및 보유기간은 다음과 같습니다.'
                '\n\n'
                '-firebase'
                '\n'
                'firebase의 개인정보 처리방침은 : https://firebase.google.com/terms/data-processing-terms에서 확인하실 수 있습니다. '
                '\n\n'
                '-AdMob'
                '\n'
                'AdMob의 개인정보처리방침은 https://policies.google.com/privacy?hl=ko 에서 확인하실 수 있습니다. '
                '\n\n\n'
                '4.보안'
                '\n\n\n'
                '앱은 제 3 자의 무단 접속이나 손실, 오용, 변경으로부터 귀하의 정보를 보호하기 위해 합리적인 조치를 취하고 있습니다. '
                ' 앱은 안전한 운영 환경에서 서비스를 통해 수집한 정보를 보관하기 위해 노력을 다하고 있으나, 해당 정보에 대한 완벽한 보안은'
                ' 보증할 수 없습니다. 앱의 보안조치가 제 3자 \'\'해커\'\'들이 불법으로 해당 정보에 대한 접근권을 획득할 수 없도록 '
                '한다는 점은 보장할 수 없습니다. 인터넷 상에서 100% 안전한 전송 방법이나 전자적 보관 방법은 없으므로, 앱은 절대적 보안을 '
                '보장할 수 없습니다.'
                '\n\n\n'
                '5.정책 업데이트'
                '\n\n\n'
                '앱은 언제든지 본 정책을 변경할 수 있는 권한을 보유합니다. 앱이 본 정책을 변경하기로 결정하는 경우, 우리는 귀하에게 수집 하는 '
                '정보들을 사용하는 것에 대해 정책 공개 시기를 알 수 있도록 항상 본 정책을 최신 상태로 유지합니다.'
                '\n\n\n'
                '6.불만사항'
                '\n\n\n'
                '개인정보 보호 정책에 대한 의견을 아래 주소로 할 수 있습니다.'
                '\n\n\n'
                '7.개인정보 보호 정책 연락처 정보'
                '\n\n\n'
                '개인정보 보호 정책에 대해 궁금한 사항이나 기타 의견이 있으면 다음 연락처로 문의 하십시오.'
                'eddyfunfun@gmail.com'
                '개인정보 취급정책 마지막 업데이트: 2021년 2월'
                '\n\n'),
          ),
        ],
      ),
    );
  }
}
