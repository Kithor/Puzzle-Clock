import 'package:flutter/material.dart';
import 'dart:math';

class Scramble extends StatelessWidget{
  	TextEditingController _controller;
  	
  @override
  Widget build (BuildContext context){
      var time = new DateTime.now();
      String w = logicWordPicker();
      String s = logicScrambler(w);

        return new Column(
          children: <Widget>[
              Text('Time to Wake Up!'),
              Text(time.toString()),
              Text('Unscramble the world to silence the alarm.'),
              Text(s),
              new TextField(
                controller: _controller,
              ),
              new RaisedButton(
                onPressed: (){
                if(_controller.text == w){
                  //Turn Alarm Off
                  //Navigate to main page
                }
                else{
                  _controller.clear();
                }
              },
          child: new Text("Try Again!"),
          ),
        ],
      );
  }
}

  /* THIS IS THE LOGIC FOR THE PUZZLE BELOW*/

String logicWordPicker(){

  // List of words available
  var wordlist = ["diary","apple","plain","ghost","nerds","fruit","giant","mouse","horse","spoon"];
  var rng = new Random();
  
  // Selects a Random Word
  var wordnum = rng.nextInt(wordlist.length);
  var word = wordlist[wordnum];

  return(word);
}

String logicScrambler(String word){
  var rng = new Random();
  var temp;
  var i;
  i = 0;
  var charactered = ["","","","",""];

  word.runes.forEach((int rune) {
      var character = new String.fromCharCode(rune);
      charactered[i] = character;
      i++;
  });
  
  //Scrambles the word
  i = 0;
  for(int j = 0; j > 5; j++){
      var loc = rng.nextInt(3);
      temp = charactered[i];
      charactered[i] = charactered [loc];
      charactered[loc] = temp;
      i++;
  }
  return(charactered.toString());
}