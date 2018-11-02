import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'alarm.dart';

class EditAlarm extends StatefulWidget{
  @override
  _EditAlarmState createState() => _EditAlarmState();
}

class _EditAlarmState extends State<EditAlarm>{
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Alarm _alarm = new Alarm();

  void submit(){
    _formKey.currentState.save();
    Alarm.fromData(_alarm.name, _alarm.time, null);
    print(Alarm.alarmList[0].time);
    Navigator.pop(context);
  }

  @override
  Widget build (BuildContext context){
    var time = new DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text("New Alarm")
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: this._formKey,
          child: ListView(
            children: <Widget>[
              TimePickerFormField(
                format: DateFormat("h:mm a"),
                decoration: InputDecoration(labelText: 'Time'),
                onSaved: (value){
                  this._alarm.time = value;
                }
              ),
              RaisedButton(
                child: const Text('Save'),
                onPressed: this.submit
              )
            ],
          )
        )
      )
        /*children: <Widget>[
          Text('Set the Alarm!'),
          Text(time.toString()),

          //https://docs.flutter.io/flutter/material/showDatePicker.html
          //This seems to be a date picker wheel, but I have questions

          new RaisedButton(
            onPressed: (){
              // Add Alarm
              // Navigator.pop(context);
          },
        ),
      ],*/
    );
  }
}