import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() {
  runApp(TestWidget());
}

enum Mode { TIMER, STOPWATCH }

class TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  Mode mode = Mode.TIMER;
  int selected=0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    intensity: 1.0,
                    boxShape: NeumorphicBoxShape.circle(),
                    lightSource: LightSource.topLeft,
                    depth: -2,
                    color: Colors.greenAccent),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,children: [
              Container(
                width: 80,
                height: 80,
                child: NeumorphicButton(
                  onPressed: (){},
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      intensity: 1.0,
                      boxShape: NeumorphicBoxShape.circle(),
                      lightSource: LightSource.topLeft,
                      depth: 5,
                      color: Colors.greenAccent),
                ),
              ),Container(
                width: 80,
                height: 80,
                child: NeumorphicButton(
                  onPressed: (){},
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      intensity: 1.0,
                      boxShape: NeumorphicBoxShape.circle(),
                      lightSource: LightSource.topLeft,
                      depth: 5,
                      color: Colors.greenAccent),
                ),
              ),Container(
                width: 80,
                height: 80,
                child: NeumorphicButton(
                  onPressed: (){},
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      intensity: 1.0,
                      boxShape: NeumorphicBoxShape.circle(),
                      lightSource: LightSource.topLeft,
                      depth: 5,
                      color: Colors.greenAccent),
                ),
              )
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width:100,
                  height: 100,
                  child: NeumorphicToggle(
                      selectedIndex:selected,
                      onChanged: (value){
                        setState(() {
                          selected = value;
                        });
                      },
                      children: [
                    ToggleElement(), ToggleElement(),
                  ], thumb: null),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
