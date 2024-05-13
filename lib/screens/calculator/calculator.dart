import "package:er_desk/widgets/screen-appbar.dart";
import "package:flutter/material.dart";
import "package:flutter_simple_calculator/flutter_simple_calculator.dart";
import "package:flutter_awesome_calculator/flutter_awesome_calculator.dart";
class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins"
      ),
      home: Scaffold(
        appBar: appBar(context, "Calculator"),
        body: Container(
          alignment: AlignmentDirectional.bottomEnd,
          child: FlutterAwesomeCalculator(
            context: context,
            digitsButtonColor: Colors.white,
            operatorsButtonColor: const Color(0xFF7B5FEB),
            backgroundColor: Colors.white,
            expressionAnswerColor: Colors.black,
            showAnswerField: true,
            onChanged: (answer,expression){
            },
          ),
        ),
      ),

    );
  }
}
