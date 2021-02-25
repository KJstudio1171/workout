import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:workout/lib_control/theme_control.dart';
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
      theme: ThemeControl.firstDesign,
      debugShowCheckedModeBanner: false,
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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.data != null) {
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Text(
                        '하루운동',
                        style: TextStyle(
                            color: color1,
                            fontFamily: 'godo',
                            fontWeight: FontWeight.bold,
                            fontSize: 50),
                      ),
                      const SizedBox(height: 300,),
                      InkWell(
                          onTap: () {
                            signInWithFacebook();
                          },
                          child: Image.asset(
                            'images/facebook.png',
                            width: 200,
                          )),
                      const SizedBox(height: 20,),
                      InkWell(
                          onTap: () {
                            signInWithGoogle();
                          },
                          child: Image.asset(
                            'images/google.png',
                            width: 205,
                          )),
                    ],
                  ),
                ),
              ),
            );
          } else {
            //print(FirebaseAuth.instance.currentUser.uid);
            return MainPage();
            /*return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${snapshot.data.displayName}님 환영합니다."),
                    FlatButton(
                      color: Colors.grey.withOpacity(0.3),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: Text("로그아웃"),
                    ),
                  ],
                ),
              );*/
          }
        },
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  Future<UserCredential> signInWithFacebook() async {
    try {
      final AccessToken accessToken = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final FacebookAuthCredential credential = FacebookAuthProvider.credential(
        accessToken.token,
      );
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FacebookAuthException catch (e) {
      // handle the FacebookAuthException
    } on FirebaseAuthException catch (e) {
      // handle the FirebaseAuthException
    } finally {}
    return null;
  }

}
