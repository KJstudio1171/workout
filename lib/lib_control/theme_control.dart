import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Color colorWhite = Colors.white;
const Color colorBlack = Colors.black;
const Color colorBlack54 = Colors.black54;
const Color color1 = Color.fromARGB(255, 161, 196, 253);
const Color color2 = Color.fromARGB(255, 80, 97, 125);
const Color color3 = Color.fromARGB(255, 121, 147, 189);
const Color color4 = Color.fromARGB(255, 253, 198, 161);
const Color color5 = Color.fromARGB(255, 189, 148, 121);
const Color color6 = Color.fromARGB(255, 255, 218, 153);
const Color color7 = Color.fromARGB(255, 120, 170, 249);
const Color color8 = Color.fromARGB(255, 41, 50, 64);
const Color color9 = Color.fromARGB(255, 211, 228, 255);
const Color color10 = Color.fromARGB(255, 82, 143, 239);
const Color color11 = Color.fromARGB(255, 253, 130, 111);
const Color color12 = Colors.blueGrey;
const Color color13 = Color.fromARGB(255, 145, 227, 189);
const Color color14 = Color.fromARGB(255, 235, 245, 255);
const Color color15 = Color.fromARGB(255, 240, 240, 245);

class ThemeContol {
  static final ThemeData firstDesign = ThemeData(
    primaryIconTheme: IconThemeData(color: color2),
    iconTheme: IconThemeData(color: color2),
    textTheme: TextTheme(
      headline1: TextStyle(),
      headline2: TextStyle(),
      headline3: TextStyle(),
      headline4: TextStyle(),
      headline5: TextStyle(),
      headline6: TextStyle(),
      subtitle1: TextStyle(),
      subtitle2: TextStyle(),
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
      caption: TextStyle(),
      button: TextStyle(),
      overline: TextStyle(),
    ).apply(
      bodyColor: color2, displayColor: color2,
      //fontFamily: 'cafe24oneprettynight',
      //fontFamily: 'cafe24simplehae',
      fontFamily: 'cafe24ssurroundair'
      //fontFamily: 'nanumgothic',
      //fontFamily: 'nanumgothicbold',
    ),
    accentTextTheme: TextTheme(
      headline1: TextStyle(),
      headline2: TextStyle(),
      headline3: TextStyle(),
      headline4: TextStyle(),
      headline5: TextStyle(),
      headline6: TextStyle(),
      subtitle1: TextStyle(),
      subtitle2: TextStyle(),
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
      caption: TextStyle(),
      button: TextStyle(),
      overline: TextStyle(),
    ).apply(bodyColor: color2, displayColor: color2),
    primaryTextTheme: TextTheme(
      headline1: TextStyle(),
      headline2: TextStyle(),
      headline3: TextStyle(),
      headline4: TextStyle(),
      headline5: TextStyle(),
      headline6: TextStyle(),
      subtitle1: TextStyle(),
      subtitle2: TextStyle(),
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
      caption: TextStyle(),
      button: TextStyle(),
      overline: TextStyle(),
    ).apply(bodyColor: color2, displayColor: color2),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: color1),
    accentColor: color1,
  );
}
