//send back messages to trigger alarms
//import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:isolate';

var prefs;

/*Future<void> getPrefsInstance() async {
  //wait until the storage is instanciated
  prefs = await SharedPreferences.getInstance();
}*/

bool isInit(){
  //grab data from storage and check if clock is running
  bool isInit = prefs.getBool('clockStarted') ?? false;
  if(isInit){
    return true;
  }
  else{
    prefs.setBool('clockStarted', true);
    return false;
  }
}

periodicTimer(SendPort sendPort){
  new Timer.periodic(new Duration(minutes: 1), (timer) {
    print('beep');
    sendPort.send('beep');
  });
}

void init(ReceivePort port) async {
  getPrefsInstance();
  if(!isInit()){
    //loop per milisecond to check for when clock = m.00.00
    new Timer.periodic(new Duration(milliseconds: 5), (timer) {
      if(DateTime.now().second == 00){
        
        timer.cancel();
      }
    });
  }
  
  return;
}  
