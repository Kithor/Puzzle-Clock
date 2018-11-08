import 'package:flutter/material.dart';
import 'dart:math';
import '../main.dart';

class Scramble extends StatefulWidget{
  @override
  _ScrambleState createState() => _ScrambleState();
}

class _ScrambleState extends State<Scramble>{
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _controller;
  
  @override  
  void initState(){
    super.initState();
  }

  void submit(){
    _formKey.currentState.save();
    dispose();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => App()),
    );
  }
  
  @override
  Widget build (BuildContext context){
    var time = new DateTime.now();
    String w = logicWordPicker();
    String s = logicScrambler(w);

      return Scaffold(
        appBar: AppBar(
          title: Text("Unscramlbe"),
          leading: new Container()
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: this._formKey,
            child: Column(
              children: <Widget>[

                Text('Current Time: '),
                Text(time.toString()),
                Text('Unscramble the word!'),
                Text(s),

                TextField(
                  controller: _controller,
                ),

                RaisedButton(
                  onPressed: (){
                    if(_controller.text == w){
                      this.submit();
                    }
                    else{
                      _controller.clear();
                    }
                  },
                child: new Text("Try Again!"),
              ),
            ],
          )
        ),
      ),
    );
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
}