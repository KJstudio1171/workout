import 'package:flutter/material.dart';

import '../lib_control/ui_size_control.dart';

class DateCard extends StatelessWidget {
  DateCard(this._date);

  String _date;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      height: 80,
      width: 80,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("$_date"),
            Text(
              "$_date",
              textScaleFactor: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class DateSection extends StatefulWidget {
  @override
  _DateSectionState createState() => _DateSectionState();
}

class _DateSectionState extends State<DateSection> {
  @override
  Widget build(BuildContext context) {
    Widget widget = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("xxxx년 x월"),
              Text(
                "오늘의 운동",
                textScaleFactor: 2,
              ),
            ],
          ),
          //padding: ,
        ),
        ConstrainedBox(
          constraints: new BoxConstraints(
            minHeight: 0,
            maxHeight: 80,
          ),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return DateCard("$index");
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: 20),
        )
      ],
    );
    return widget;
  }
}
