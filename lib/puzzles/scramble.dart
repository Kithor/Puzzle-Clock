import 'package:flutter/material.dart';
import 'dart:math';
import '../main.dart';

class Scramble extends StatefulWidget{
  @override
  _ScrambleState createState() => _ScrambleState();
}

class _ScrambleState extends State<Scramble>{
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  var w,s;
  
  @override  
  void initState(){
    super.initState();
    w = logicWordPicker();
    s = logicScrambler(w);
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
      return Scaffold(
        appBar: AppBar(
          title: Text("Unscramlbe"),
          leading: new Container()
        ),
        body: 
        new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child:Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: this._formKey,
            child: Column(
              children: <Widget>[

                Text('Unscramble the word!', style: TextStyle(fontSize: 20.0, color: Colors.white)),
                Text(s, style: TextStyle(fontSize: 40.0, color: Colors.white)),

                TextFormField(
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value){
                    if(value.toString().isEmpty){
                      return 'Please enter an answer';
                    }
                    if(value.toString() != w.toString()){
                      return 'Incorrect Answer';
                    }
                  }
                ),
                
                RaisedButton(
                  child: const Text('Solve'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                        this.submit();
                    }
                  }
              ),
            ],
          )
        ),
      ),
    )
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
  var i = 0;
  var charactered = ["","","","",""];

  word.runes.forEach((int rune) {
      var character = new String.fromCharCode(rune);
      charactered[i] = character;
      i++;
  });
  
  //Scrambles the word
  i = 0;
    charactered.forEach((rune){
        var loc = rng.nextInt(3);
        temp = charactered[i];
        charactered[i] = charactered [loc];
        charactered[loc] = temp;
        i++;
    });
  return(charactered.toString());
  } 
}