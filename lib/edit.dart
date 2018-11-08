import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'main.dart';
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => App()),
    );
  }

  @override
  Widget build (BuildContext context){
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
              TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter an alarm name';
                    }
                  },
                  onSaved: (value){
                    this._alarm.name = value;
                  }
                ),
              TimePickerFormField(
                format: DateFormat("h:mm a"),
                decoration: InputDecoration(labelText: 'Time'),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Please enter a time';
                  }
                },
                onSaved: (value){
                  var now = DateTime.now();
                  this._alarm.time = new DateTime(now.year, now.month, now.day, value.hour, value.minute);
                  print(now);
                  print(this._alarm.time);
                }
              ),
              RaisedButton(
                child: const Text('Save'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                      this.submit();
                  }
                }
              )
            ],
          )
        )
      )
    );
  }
}