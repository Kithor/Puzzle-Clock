class Alarm{
  static var alarmsList = List();

  var name;
  var time; //format will be HHmm
  var repeatedFor = {
    'Mo':'',
    'Tu':'',
    'We':'',
    'Th':'',
    'Fr':'',
    'Sa':'',
    'Su':''
  };
  bool alarmSet;
  var sound;

  Alarm(var n, var t, var r, var s){
    if(n == null)
      name = "Alarm ${alarmsList.length + 1}";
    else
      name = n;
    time = t;
  //set repeated
    sound = s;

    alarmsList.add(this);
  }

  void removeAlarm(var name){
    //find alarm by name and remove it from list of alarms
  }
}

//array == list, syntax: var <list_name> = [<values>]
//map could link an alarm name to obj? var <map_name> = Map()
