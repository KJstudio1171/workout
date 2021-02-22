import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import '../lib_control/theme_control.dart';

enum Weight { TRUE, FALSE }
enum WorkoutType { REPS, TIME }

class SetInfo extends StatefulWidget {
  @override
  _SetInfoState createState() => _SetInfoState();
}

class _SetInfoState extends State<SetInfo> {
  List<String> result = [];
  var workoutType = WorkoutType.REPS;
  bool _value = false;
  bool _reps = true;
  bool _time = false;
  String _unitWeight = 'kg';
  String _unitTime = '분';
  TextEditingController _controllerSet = TextEditingController();
  TextEditingController _controllerWeight = TextEditingController();
  TextEditingController _controllerReps = TextEditingController();
  TextEditingController _controllerTime = TextEditingController();

  _valueChange(bool value) {
    setState(() {
      _value = value;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    result.clear();
    super.dispose();
    _controllerWeight.dispose();
    _controllerTime.dispose();
    _controllerReps.dispose();
    _controllerSet.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerSet.text = '1';
    _controllerReps.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SET 추가'),
        backgroundColor: color1,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 200,
            child: ListTile(
              // leading: Text('세트:',style: TextStyle(color: color5,fontSize: 20),),
              title: TextFormField(
                controller: _controllerSet,
                textAlign: TextAlign.end,
                keyboardType: TextInputType.number,
                style: TextStyle(color: color5, fontSize: 20),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color1, width: 3.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color7, width: 3.0)),
                  border: OutlineInputBorder(),
                ),
              ),
              trailing: Text(
                '세트',
                style: TextStyle(color: color5, fontSize: 20),
              ),
            ),
          ),
          ListTile(
            enabled: _value,
            title: TextFormField(
              controller: _controllerWeight,
              textAlign: TextAlign.end,
              style: TextStyle(color: color5),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color1, width: 3.0)),
                disabledBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: color9)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color7, width: 3.0)),
                labelText: '중량',
                helperText: '무게를 입력하세요',
                border: OutlineInputBorder(),
              ),
              enabled: _value,
            ),
            leading: Checkbox(
              value: _value,
              onChanged: _valueChange,
            ),
            trailing: DropdownButton<String>(
              value: _unitWeight,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: color2),
              underline: Container(
                height: 2,
                color: color1,
              ),
              onChanged: (String newValue) {
                setState(() {
                  _unitWeight = newValue;
                });
              },
              items: <String>['kg', 'g', 'lbs']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: color5),
                  ),
                );
              }).toList(),
            ),
          ),
          ListTile(
              trailing: SizedBox(
                width: 43,
                child: Text(
                  '번',
                  style: TextStyle(color: color5),
                ),
              ),
              title: TextFormField(
                controller: _controllerReps,
                textAlign: TextAlign.end,
                style: TextStyle(color: color5),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color1, width: 3.0)),
                  disabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: color9)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color7, width: 3.0)),
                  labelText: '반복',
                  helperText: '한세트당 몇번 반복할 건가요?',
                  border: OutlineInputBorder(),
                ),
                enabled: _reps,
              ),
              leading: Radio(
                  value: WorkoutType.REPS,
                  groupValue: workoutType,
                  onChanged: (value) {
                    setState(() {
                      _controllerTime.text = '';
                      _reps = true;
                      _time = false;
                      workoutType = value;
                    });
                  })),
          ListTile(
            trailing: DropdownButton<String>(
              value: _unitTime,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: color2),
              underline: Container(
                height: 2,
                color: color1,
              ),
              onChanged: (String newValue) {
                setState(() {
                  _unitTime = newValue;
                });
              },
              items: <String>['분', '시간', '초']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: color5),
                  ),
                );
              }).toList(),
            ),
            title: TextFormField(
              controller: _controllerTime,
              textAlign: TextAlign.end,
              style: TextStyle(color: color5),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color1, width: 3.0)),
                disabledBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: color9)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color7, width: 3.0)),
                labelText: '시간',
                helperText: '시간을 입력하세요',
                border: OutlineInputBorder(),
              ),
              enabled: _time,
            ),
            leading: Radio(
                value: WorkoutType.TIME,
                groupValue: workoutType,
                onChanged: (value) {
                  setState(() {
                    _controllerReps.text = '';
                    _time = true;
                    _reps = false;
                    workoutType = value;
                  });
                }),
          ),
          RaisedButton(
            onPressed: () {
              result.add(_controllerSet.text);
              result.add(_controllerWeight.text);
              result.add(_controllerReps.text);
              result.add(_controllerTime.text);
              result.add(_unitWeight);
              result.add(_unitTime);
              Get.back(result: result);
            },
            child: Text('추가'),
            color: color1,
          ),
        ],
      ),
    );
  }
}
