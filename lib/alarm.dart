import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import './puzzles/puzzle.dart';

class Alarm{
  static List<Alarm> alarmList = [];
  static var clockStarted = false;
  static AudioCache audioCache = new AudioCache();
  static AudioPlayer audioPlayer;
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

  static void loadAudio(){
    audioCache.loadAll(['audio/deja.mp3','audio/stars.mp3']);
  }

  static void stop(){
    audioPlayer.stop();
  }

  void start(context) async{
    audioPlayer = await audioCache.loop('audio/stars.mp3');
    puzzlePicker(context);
  }
}

//array == list, syntax: var <list_name> = [<values>]
//map could link an alarm name to obj? var <map_name> = Map()
