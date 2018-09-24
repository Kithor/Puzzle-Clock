//send back messages to trigger alarms
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Clock{
  static var prefs;

  static Future<void> getPrefsInstance() async {
    //wait until the storage is instanciated
    prefs = await SharedPreferences.getInstance();
  }

  static bool isInit(){
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

  static void tempPeriod(){
    new Timer.periodic(new Duration(minutes: 1), (timer) {
      /*------ Figure out how to contact the app/appstate to call check clock ------*/
    });
  }

  static void init(){
    getPrefsInstance();
    if(!isInit()){
      //loop per milisecond to check for when clock = m.00.00
      new Timer.periodic(new Duration(milliseconds: 5), (timer) {
        if(DateTime.now().second == 00){
          //start isolate periodic process
            //creating a temp periodic for testing
            tempPeriod();
          //end timer
          timer.cancel();
        }
      });
    }
    
    return;
  }
}