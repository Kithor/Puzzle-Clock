import 'package:flutter/material.dart';
import 'dart:math';
import '../main.dart';

class Riddle extends StatefulWidget{
  @override
  _RiddleState createState() => _RiddleState();
}

class _RiddleState extends State<Riddle>{
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  var riddle;	
  
  @override  
  void initState(){
    super.initState();
    riddle = getRiddle();
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
        title: Text("Riddles!"),
        leading: new Container()
      ),
      body: 
      new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: this._formKey,
          child: Column(
            children: <Widget>[
              Text ('${riddle['question']}',
                style: new TextStyle(
                  fontSize: 30.0,
                  color: Colors.white
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder()
                ),                  
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white            
                ),
                validator: (value){
                  if(value.toString().isEmpty){
                    return 'Please enter an answer';
                  }
                  if(value.toLowerCase() != riddle['answer']){
                    print(riddle['answer']);
                    return 'Incorrect Answer';
                  }
                },
              ),
              RaisedButton(
                child: const Text('Save'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                      this.submit();
                  }
                }            
              )
            ]
          )
        )
      )
    )
    );
  }
}

/* THIS IS THE LOGIC FOR THE PUZZLE BELOW*/
getRiddle(){
  var randomNum = new Random().nextInt(5);
  var riddle;

  switch(randomNum) {
    case 0: {
      riddle = {
        'question': 'Who is the best Computer Science Professor at SELU?',
        'answer': 'pao'
      };
    }
    break;

    case 1: {
      riddle = {
        'question': 'What has to be broken before you can use it?',
        'answer': 'egg'
      };
    }
    break;

    case 2: {
      riddle = {
        'question': 'What has hands but cannot clap?',
        'answer': 'clock'
      };
    }
    break;

    case 3: {
      riddle = {
        'question': 'Which letter of the alphabet has the most water?',
        'answer': 'c'
      };
    }
    break;

    case 4: {
      riddle = {
        'question': 'It lives in winter, dies in summer, and grows with its roots on top. What is it?',
        'answer': 'icicle'
      };
    }
    break;

    case 5: {
      riddle = {
        'question': 'What word is spelled wrong in every dictionary?',
        'answer': 'wrong'
      };
    }
    break;
  }
  
  
  return riddle;
}