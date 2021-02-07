import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() => runApp(TestWidget()
    /*ChangeNotifierProvider(
          create: (context) => SimpleState(),
          child: StateLoginDemo(),*/
    );

class TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  bool pressed = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'MainPage',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Expanded(
                  child: ListView.separated(
                      padding: EdgeInsets.all(0),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ExpansionTile(
                          title: Text('asdas'),
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    RaisedButton(onPressed: () {
                                      setState(() {});
                                    }),
                                  ],
                                ),
                                GridView.builder(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(20),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return nemorphicSet(index);
                                  },
                                  itemCount: 10,
                                ),
                              ],
                            ),
                          ],
                        );
                        //return WorkOutCard("$index");
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: 20)),
            ],
          )),
    );
  }

  NeumorphicButton nemorphicSet(int index) {
    return NeumorphicButton(
      onPressed: () {
        setState(() {
          pressed = false;
        });
      },
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        intensity: 1.0,
        boxShape: NeumorphicBoxShape.circle(),
        lightSource: LightSource.topLeft,
        depth: -2,
        color: Color.fromARGB(255, 161, 196, 253),
      ),
      child: Center(
          child: Text(
        '$index' + 'x',
        style: TextStyle(
            fontSize: 17, color: pressed ? Colors.white : Colors.cyanAccent),
      )),
    );
  }
}
