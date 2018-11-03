class Alarm{
  static List<Alarm> alarmList = [];
  var name;
  var time;
  var repeatedFor = {
    'Mo':'', 'Tu':'', 'We':'', 'Th':'', 'Fr':'', 'Sa':'', 'Su':''
  };
  bool isSet;
  var sound;

  Alarm(){
    this.name = 'defaut';
    this.time = '12:00';
    this.isSet = false;
  }

  Alarm.fromData(this.name, this.time, this.sound){
    this.isSet = true;
    alarmList.add(this);
  }
  
  void removeAlarm(var name){
    //find alarm by name and remove it from list of alarms
  }

  void start(){
    /* Start a loop playing the sound until puzzle is complete.
    We will probably want to play with isolates here. I don't think
    we will be able to run both a puzzle and the sound. If anyone
    wants to look into that.*/
  }
}

//array == list, syntax: var <list_name> = [<values>]
//map could link an alarm name to obj? var <map_name> = Map()
