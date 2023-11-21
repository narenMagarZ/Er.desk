import "package:er_desk/widgets/screen-appbar.dart";
import "package:flutter/material.dart";

class TemperatureConversion extends StatefulWidget {
  const TemperatureConversion({super.key});

  @override
  State<TemperatureConversion> createState() => _TemperatureConversionState();
}

class _TemperatureConversionState extends State<TemperatureConversion> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins"
      ),
      home: Scaffold(
        appBar: appBar(context, "Weight Conversion"),
        body: Container(),
      ),
    );
  }
}
