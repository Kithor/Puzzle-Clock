import 'package:flutter/material.dart';
import 'dart:math';
import '../main.dart';

class Math extends StatefulWidget{
  @override
  _MathState createState() => _MathState();
}

class _MathState extends State<Math>{
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  var _eqn;	
  var count = 0;
  
  @override  
  void initState(){
    super.initState();
    _eqn = createEqn();
  }

  void submit(){
    _formKey.currentState.save();
    if(count < 2){
      setState(() {
        _eqn = createEqn();
      });
    } else {
      super.dispose();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => App()),
      );
    }
    count++;
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Math Problem"),
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
              Text ('${_eqn['num1']} ${_eqn['op']} ${_eqn['num2']} =',
                style: new TextStyle(
                  fontSize: 90.0,
                  color: Colors.white
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  border: OutlineInputBorder()
                ),                  
                style: new TextStyle(
                  fontSize: 40.0,
                  color: Colors.white            
                ),
                validator: (value){
                  if(value.toString().isEmpty){
                    return 'Please enter an answer';
                  }
                  if(value.toString() != _eqn['ans'].toString()){
                    print(_eqn['ans']);
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
createEqn(){
  var randomNum1 = new Random().nextInt(21);
  var randomNum2 = new Random().nextInt(21);
  var randomOper = new Random().nextInt(2);
  var operDisp;
  var answer;

  if (randomOper == 0) {
      operDisp = '-';
      answer = randomNum1 - randomNum2;
  }
  else if (randomOper == 1) {
      operDisp = '+';
      answer = randomNum1 + randomNum2;
  }

  var obj = {
    'num1': randomNum1,
    'num2': randomNum2,
    'op': operDisp,
    'ans': answer
  };
  return obj;
}