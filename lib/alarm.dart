class Alarm{
  static int numOfAlarms;
  var name;
  var time; //format will be HHmm
  var repeatedFor = {
    'Mo':'', 'Tu':'', 'We':'', 'Th':'', 'Fr':'', 'Sa':'', 'Su':''
  };
  bool isSet;
  var sound;

  Alarm(var n, var t, var s){
    if(numOfAlarms == null) numOfAlarms = 0;
    if(n == null)
      this.name = "Alarm $numOfAlarms";
    else
      this.name = n;
    this.time = t;
    this.sound = s;

    this.isSet = true;
    numOfAlarms++;
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
