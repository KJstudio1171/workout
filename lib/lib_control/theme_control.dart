import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Color colorWhite = Colors.white;
Color colorBlack = Colors.black;
Color colorBlack54 = Colors.black54;
Color color1 = Color.fromARGB(255, 161, 196, 253);
Color color2 = Color.fromARGB(255, 80, 97, 125);
Color color3 = Color.fromARGB(255,121, 147, 189);
Color color4 = Color.fromARGB(255,253, 198, 161);
Color color5 = Color.fromARGB(255,189, 148, 121);
Color color6 = Color.fromARGB(255,255, 218, 153);
Color color7 = Color.fromARGB(255,120, 170, 249);
Color color8 = Color.fromARGB(255, 41, 50, 64);
Color color9 = Color.fromARGB(255,211, 228, 255);
Color color10 = Color.fromARGB(255,82, 143, 239);
Color color11 = Color.fromARGB(255, 253, 130, 111);
Color color12 = Colors.blueGrey;
Color color13 = Color.fromARGB(255, 161, 253, 210);
Color color14 = Color.fromARGB(255, 145, 227, 189);
Color color15 = Color.fromARGB(255, 235, 245, 255);


class ThemeContol {
  static final ThemeData firstDesign = ThemeData(
    textTheme: TextTheme(
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
    ).apply(
      bodyColor: color2,
      displayColor: color2
    ),
    accentColor: color1,
  );
}
