import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:group_button/group_button.dart';

import 'package:workout/lib_control/theme_control.dart';

class CalendarChart extends StatelessWidget {
  CalendarChart(this.event);

  final Map event;
  final DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final DateTime lastYear = today.subtract(Duration(days: 365));
    final DateTime lastMonth = today.subtract(Duration(days: 31));
    final DateTime lastWeek = today.subtract(Duration(days: 7));

    Map graphAll = {};
    Map graphYear = {};
    Map graphMonth = {};
    Map graphWeek = {};
    event.forEach((key, value) {
      if (lastWeek.isBefore(key)) {
        value[0]['category'].forEach((e) {
          if (!graphWeek.containsKey(e)) {
            print(key);
            graphWeek.addAll({e: 1});
          } else {
            graphWeek[e] += 1;
          }
        });
      }
      if (lastMonth.isBefore(key)) {
        value[0]['category'].forEach((e) {
          if (!graphMonth.containsKey(e.toString())) {
            graphMonth.addAll({e: 1});
          } else {
            graphMonth[e] += 1;
          }
        });
      }
      if (lastYear.isBefore(key)) {
        value[0]['category'].forEach((e) {
          if (!graphYear.containsKey(e.toString())) {
            graphYear.addAll({e: 1});
          } else {
            graphYear[e] += 1;
          }
        });
      }
      value[0]['category'].forEach((e) {
        if (!graphAll.containsKey(e.toString())) {
          graphAll.addAll({e: 1});
        } else {
          graphAll[e] += 1;
        }
      });

      print(graphAll);
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
        title: Text('차트'),
      ),
      body: PieChartWorkout(graphAll, graphYear, graphMonth, graphWeek),
    );
  }
}

class PieChartWorkout extends StatefulWidget {
  PieChartWorkout(
      this.graphAll, this.graphYear, this.graphMonth, this.graphWeek);

  final Map graphAll;
  final Map graphYear;
  final Map graphMonth;
  final Map graphWeek;

  @override
  _PieChartWorkoutState createState() => _PieChartWorkoutState();
}

class _PieChartWorkoutState extends State<PieChartWorkout> {
  int index = 0;
  int touchedIndex;
  List<Map> mapList = [];
  Map modeChanger;
  List colors = [
    color1,
    color2,
    color3,
    color4,
    color5,
    color6,
    color7,
    color8,
    color9,
    color10
  ];
  List<String> mode = ['일주일', '한달', '일년', '전체'];

  @override
  void initState() {
    index = widget.graphAll.length;
    mapList.add(widget.graphWeek);
    mapList.add(widget.graphMonth);
    mapList.add(widget.graphYear);
    mapList.add(widget.graphAll);
    modeChanger = mapList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        ListTile(
          title: Center(
              child: Text(
            '운동 부위별 비율 차트',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )),
        ),
        GroupButton(
          isRadio: true,
          spacing: 5,
          buttons: mode,
          onSelected: (index, isSelected) {
            setState(() {
              modeChanger = mapList[index];
            });
          },
          selectedColor: color1,
          unselectedShadow: [BoxShadow(color: Colors.transparent)],
          selectedButtons: null,
        ),
        AspectRatio(
          aspectRatio: 1,
          child: Card(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 28,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: textBox(modeChanger),
                ),
                const SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                          pieTouchData:
                              PieTouchData(touchCallback: (pieTouchResponse) {
                            setState(() {
                              if (pieTouchResponse.touchInput
                                      is FlLongPressEnd ||
                                  pieTouchResponse.touchInput is FlPanEnd) {
                                touchedIndex = -1;
                              } else {
                                touchedIndex =
                                    pieTouchResponse.touchedSectionIndex;
                              }
                            });
                          }),
                          startDegreeOffset: 180,
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 1,
                          centerSpaceRadius: 0,
                          sections: showingSections(modeChanger)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> textBox(Map map) {
    List<Widget> list = [];
    int i = 0;
    map.forEach((key, value) {
      list.add(Indicator(
        color: colors[i],
        text: key,
        isSquare: false,
        size: touchedIndex == i ? 18 : 16,
        textColor: touchedIndex == i ? Colors.black : Colors.grey,
      ));
      i++;
    });
    i = 0;
    return list;
  }

  List<PieChartSectionData> showingSections(Map map) {
    List<PieChartSectionData> list = [];
    int i = 0;
    int sumValues = 0;
    map.forEach((key, value) {
      sumValues += value;
    });
    map.forEach((key, value) {
      final isTouched = i == touchedIndex;
      final double opacity = isTouched ? 1 : 0.6;
      final double radius = isTouched ? 150 : 128;
      list.add(PieChartSectionData(
        color: colors[i] ?? color1
          ..withOpacity(opacity),
        value: value.toDouble(),
        title: '$key' '\n' '${(value / sumValues * 100).toStringAsFixed(2)} %',
        radius: radius,
        titleStyle: TextStyle(
            fontSize: isTouched ? 16 : 14,
            fontWeight: FontWeight.bold,
            color: colors[i + 1] ?? color1),
        titlePositionPercentageOffset: 0.7,
      ));
      i++;
    });
    i = 0;
    return list;
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}

/*
class PieChartSample1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartSample1State();
}

class PieChartSample1State extends State {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 28,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Indicator(
                  color: const Color(0xff0293ee),
                  text: 'One',
                  isSquare: false,
                  size: touchedIndex == 0 ? 18 : 16,
                  textColor: touchedIndex == 0 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: const Color(0xfff8b250),
                  text: 'Two',
                  isSquare: false,
                  size: touchedIndex == 1 ? 18 : 16,
                  textColor: touchedIndex == 1 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: const Color(0xff845bef),
                  text: 'Three',
                  isSquare: false,
                  size: touchedIndex == 2 ? 18 : 16,
                  textColor: touchedIndex == 2 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: const Color(0xff13d38e),
                  text: 'Four',
                  isSquare: false,
                  size: touchedIndex == 3 ? 18 : 16,
                  textColor: touchedIndex == 3 ? Colors.black : Colors.grey,
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      startDegreeOffset: 180,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 1,
                      centerSpaceRadius: 0,
                      sections: showingSections()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;
        final double opacity = isTouched ? 1 : 0.6;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: const Color(0xff0293ee).withOpacity(opacity),
              value: 25,
              title: '',
              radius: 80,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff044d7c)),
              titlePositionPercentageOffset: 0.55,
            );
          case 1:
            return PieChartSectionData(
              color: const Color(0xfff8b250).withOpacity(opacity),
              value: 25,
              title: '',
              radius: 65,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff90672d)),
              titlePositionPercentageOffset: 0.55,
            );
          case 2:
            return PieChartSectionData(
              color: const Color(0xff845bef).withOpacity(opacity),
              value: 25,
              title: '',
              radius: 60,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff4c3788)),
              titlePositionPercentageOffset: 0.6,
            );
          case 3:
            return PieChartSectionData(
              color: const Color(0xff13d38e).withOpacity(opacity),
              value: 25,
              title: '',
              radius: 70,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff0c7f55)),
              titlePositionPercentageOffset: 0.55,
            );
          default:
            return null;
        }
      },
    );
  }
}

class PieChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections()),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Indicator(
                  color: Color(0xff0293ee),
                  text: 'First',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xfff8b250),
                  text: 'Second',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff845bef),
                  text: 'Third',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff13d38e),
                  text: 'Fourth',
                  isSquare: true,
                ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}
*/
