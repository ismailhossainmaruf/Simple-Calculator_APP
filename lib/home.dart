import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Widget calcbtn(String btntxt,Color btncolor,Color txtcolor){
    return Container(
      child: MaterialButton(
        onPressed: (){
          resultcalculation(btntxt);
        },
        child: Text(btntxt,
          style: TextStyle(
              color: txtcolor,
              fontSize: 35
          ),),
        shape: CircleBorder(),
        color: btncolor,
        padding: EdgeInsets.all(15),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
        backgroundColor: Colors.black,
        title: Text("Calculator",
          style: TextStyle(
              color: Colors.white
          ),),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white10,
                  width: double.infinity,
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(text,style: TextStyle(
                            color: Colors.white,
                            fontSize: 100
                        ),
                          textAlign: TextAlign.left,)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbtn("AC", Colors.red, Colors.white),
                  calcbtn("+/-", Colors.grey, Colors.black),
                  calcbtn("%", Colors.grey, Colors.black),
                  calcbtn("/", Colors.amber.shade700, Colors.black),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbtn("7", Colors.grey, Colors.black),
                  calcbtn("8", Colors.grey, Colors.black),
                  calcbtn("9", Colors.grey, Colors.black),
                  calcbtn("x", Colors.amber.shade700, Colors.black),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbtn("4", Colors.grey, Colors.black),
                  calcbtn("5", Colors.grey, Colors.black),
                  calcbtn("6", Colors.grey, Colors.black),
                  calcbtn("-", Colors.amber.shade700, Colors.black),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbtn("1", Colors.grey, Colors.black),
                  calcbtn("2", Colors.grey, Colors.black),
                  calcbtn("3", Colors.grey, Colors.black),
                  calcbtn("+", Colors.amber.shade700, Colors.black),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // MaterialButton(
                  //   onPressed: (){},
                  //   child: Text("0",
                  //     style: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 35
                  //     ),),
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(50)
                  //   ),
                  //   color: Colors.grey,
                  //   padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                  // ),
                  calcbtn("⌫", Colors.red, Colors.white),
                  calcbtn("0", Colors.grey, Colors.black),
                  calcbtn(".", Colors.grey, Colors.black),
                  calcbtn("=", Colors.amber.shade700, Colors.black),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void resultcalculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';

    }
    else if(btnText == "⌫"){

      finalResult = finalResult.substring(0, finalResult.length - 1);
      if(finalResult == ""){
        finalResult = "0";
      }
    }
    else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == 'x') {
        finalResult = mul();
      } else if( preOpr == '/') {
        finalResult = div();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;

    }

    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });

  }


  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
