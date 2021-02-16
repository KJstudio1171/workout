import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DateSection extends StatefulWidget {
  DateSection(this.dateTime);

  DateTime dateTime;

  @override
  _DateSectionState createState() => _DateSectionState();
}

class _DateSectionState extends State<DateSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(left: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 8,),
              Text(
                  "${widget.dateTime.year}년 ${widget.dateTime.month}월 ${widget.dateTime.day}일"),
              Text(
                "오늘의 운동",
                textScaleFactor: 2,
              ),
              SizedBox(height: 1,),
            ],
          ),
          //padding: ,
        ),
        /*ConstrainedBox(
          constraints: new BoxConstraints(
            minHeight: 0,
            maxHeight: 80,
          ),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return DateCard(
                    "${dateTime.add(Duration(days: index - 10)).day}");
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: 50),
        )*/
      ],
    );
  }
}

class DateCard extends StatelessWidget {
  DateCard(this._date);

  final String _date;

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
