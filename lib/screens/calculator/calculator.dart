import "package:flutter/material.dart";
import "package:flutter_simple_calculator/flutter_simple_calculator.dart";
import "package:flutter_awesome_calculator/flutter_awesome_calculator.dart";
class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterAwesomeCalculator(
      context: context,
      digitsButtonColor: Colors.white,
      backgroundColor: Colors.white,
      expressionAnswerColor: Colors.black,
      showAnswerField: true,
      onChanged: (answer,expression){},
    );
  }
}
