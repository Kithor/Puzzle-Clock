import 'package:flutter/material.dart';

class EditAlarm extends StatelessWidget{
  	
@override
  Widget build (BuildContext context){
      var time = new DateTime.now();

        return new Column(
          children: <Widget>[
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
        ],
      );
    }
  }