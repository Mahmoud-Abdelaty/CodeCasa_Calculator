import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

var input = '';
var output = '0';

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    output,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 1,
              width: 350,
              color: Colors.grey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      AnimatedButtonWidget(
                        text: 'Ac',
                        colorBegin: Colors.indigo,
                        colorButton: Colors.indigo,
                      ),
                      AnimatedButtonWidget(
                        text: 'Del',
                        colorBegin: Colors.indigo,
                        colorButton: Colors.indigo,
                      ),
                      AnimatedButtonWidget(
                        text: '/',
                        colorBegin: Colors.indigo,
                        colorButton: Colors.indigo,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      AnimatedButtonWidget(text: '7'),
                      AnimatedButtonWidget(text: '8'),
                      AnimatedButtonWidget(text: '9'),
                    ],
                  ),
                  Row(
                    children: [
                      AnimatedButtonWidget(text: '4'),
                      AnimatedButtonWidget(text: '5'),
                      AnimatedButtonWidget(text: '6'),
                    ],
                  ),
                  Row(
                    children: [
                      AnimatedButtonWidget(text: '1'),
                      AnimatedButtonWidget(text: '2'),
                      AnimatedButtonWidget(text: '3'),
                    ],
                  ),
                  Row(
                    children: [
                      AnimatedButtonWidget(width: 160, text: '0'),
                      AnimatedButtonWidget(
                        fontSize: 40,
                        text: '.',
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedButtonWidget(
                    text: '*',
                    colorBegin: Colors.indigo,
                    colorButton: Colors.indigo,
                  ),
                  AnimatedButtonWidget(
                    text: '-',
                    colorBegin: Colors.indigo,
                    colorButton: Colors.indigo,
                  ),
                  AnimatedButtonWidget(
                    height: 115,
                    text: '+',
                    colorBegin: Colors.indigo,
                    colorButton: Colors.indigo,
                  ),
                  AnimatedButtonWidget(
                    height: 115,
                    text: '=',
                    colorBegin: Colors.indigo,
                    colorButton: Colors.indigo,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget AnimatedButtonWidget({
    text,
    double height = 70.0,
    double width = 70.0,
    double fontSize = 30.0,
    colorBegin = Colors.blueGrey,
    colorEnd = Colors.white,
    colorButton = Colors.blueGrey,
  }) =>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: AnimatedButton(
          width: width,
          height: height,
          color: colorButton,
          onPressed: () {
            setState(() {
              OnPressedButton(text);
            });
            FocusScope.of(context).requestFocus(FocusNode());
          },
          enabled: true,
          shadowDegree: ShadowDegree.light,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topLeft,
                colors: [colorBegin, colorEnd],
              ),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color:
                      const Color.fromARGB(255, 255, 255, 255).withOpacity(.8),
                  fontFamily: 'PlaypenSans',
                  fontSize: fontSize,
                ),
              ),
            ),
          ),
        ),
      );

  OnPressedButton(text) {
    if (text == 'Ac') {
      input = '';
      output = '0';
      return;
    }
    if (text == '=') {
      output = calculate();
      if (output.endsWith('.0')) {
        output = output.replaceAll('.0', '');
      }
      return;
    }

    if (text == 'Del') {
      input = input.substring(0, input.length - 1);
      return;
    }
    input = input + text;
    setState(() {});
  }

  calculate() {
    try {
      var exp = Parser().parse(input);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return 'Error';
    }
  }
}
