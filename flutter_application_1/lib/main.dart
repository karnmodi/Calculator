
import 'package:flutter/material.dart';
import 'package:flutter_application_1/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

var userQuestion = '';
var userAnswers = '';

final myTextStyle = TextStyle(fontSize: 30, color: Colors.deepPurple [900]);

class _HomePageState extends State<HomePage> {

  final List<String> buttons = 
  [
    'C' , '<- ' , '%' , '/',
    '7' , '8' , '9' , 'x',
    '4' , '5' , '6' , '-',
    '1' , '2' , '3' , '+',
    '0' , '00' , '.' , '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 50,),
                  
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(userQuestion, style: TextStyle(fontSize: 40),),
                    ),

                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userAnswers , style: TextStyle(fontSize: 40),),
                  )
                ]
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), 
                itemBuilder: (BuildContext context, int index ){
                  if (index == 0) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = '';
                          userAnswers = '';
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.green,
                      textColor: Colors.white);
                      
                      // clear button
                  }

                  else if(index == 1) {
                    return MyButton(
                      buttonTapped: (){
                        setState(() {
                          userQuestion = userQuestion.substring(0,userQuestion.length-1);
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.red,
                      textColor: Colors.white);
                  
                    // Delete Button
                  }

                  // Equal Button
                  else if(index == buttons.length-1) {
                    return MyButton(
                      buttonTapped: (){
                        setState(() {
                          equalPressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.green,
                      textColor: Colors.white);
                  }


                  else{
                    return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion += buttons[index];
                        
                      });
                    },
                    buttonText: buttons[index],
                    color:isOperator(buttons[index]) ? Colors.amber : Colors.amber[50] ,
                    textColor: isOperator(buttons[index]) ? Colors.white : Colors.black,
                    );
                  }
                }),
            ),
          ),
        ],
      ),
    );
  }
  
bool isOperator(String x){
  if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
    return true;
  }
  return false;
}

void equalPressed(){
  String finalQuestion = userQuestion;
  finalQuestion= finalQuestion.replaceAll('x', '*');

  Parser p = Parser();
  Expression exp = p.parse(finalQuestion);
  ContextModel cm = ContextModel();
  double res = exp.evaluate(EvaluationType.REAL, cm);

  userAnswers = res.toString();

}

}
