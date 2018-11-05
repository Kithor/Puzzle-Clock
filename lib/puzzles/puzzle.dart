import 'dart:math';
import 'package:flutter/material.dart';
import 'scramble.dart';
import 'math.dart';

class Puzzle{
  static List puzzleList;
  var isComplete;

  //puzzlePicker(context);
}

void puzzlePicker(BuildContext context){
    //Picks a random puzzle from the four and navigates to the appropriate page
    var rng = new Random();
    var choice = rng.nextInt(3);

    if(choice == 0){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Math()),
      );
    }
    if(choice == 1){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Math()),
      );  
    }
    if(choice == 2){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Math()),
      );  
    }
    if(choice == 3){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Math()),
      );
    }
}