import "package:flutter/material.dart";
import "../../widgets/screen-appbar.dart";

class WeightConversion extends StatefulWidget {
  const WeightConversion({super.key});

  @override
  State<WeightConversion> createState() => _WeightConversionState();
}

class _WeightConversionState extends State<WeightConversion> {
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
    );;
  }
}
