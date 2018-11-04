import './puzzles/puzzle.dart';

class Alarm{
  static List<Alarm> alarmList = [];
  static var clockStarted = false;
  var name;
  var time;
  var repeatedFor = {
    'Mo':'', 'Tu':'', 'We':'', 'Th':'', 'Fr':'', 'Sa':'', 'Su':''
  };
  bool isSet;
  var sound;

  Alarm(){
    this.name = 'defaut';
    this.time = new DateTime.now().minute + 5;
    this.isSet = false;
  }

  Alarm.fromData(this.name, this.time, this.sound){
    this.isSet = true;
    alarmList.add(this);
  }
  
  void removeAlarm(var name){
    //find alarm by name and remove it from list of alarms
  }

  void start(context){
    /* Notification with sound */
    //trigger puzzle
    print('trigger puzzle');
    puzzlePicker(context);
  }
}

//array == list, syntax: var <list_name> = [<values>]
//map could link an alarm name to obj? var <map_name> = Map()
