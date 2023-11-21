import "package:er_desk/widgets/screen-appbar.dart";
import "package:flutter/material.dart";

class SpeedConversion extends StatelessWidget {
  const SpeedConversion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins"
      ),
      home: Scaffold(
        appBar: appBar(context, "Speed Conversion"),
        body: Container(
          padding: const EdgeInsets.all(4),
          child: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: SpeedInputBox(),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                   child: SpeedDropDownButton(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SpeedInputBox extends StatefulWidget {
  const SpeedInputBox({super.key});

  @override
  State<SpeedInputBox> createState() => _SpeedInputBoxState();
}

class _SpeedInputBoxState extends State<SpeedInputBox> {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      keyboardType: TextInputType.number,
    );
  }
}

class SpeedDropDownButton extends StatefulWidget {
  const SpeedDropDownButton({super.key});

  @override
  State<SpeedDropDownButton> createState() => _SpeedDropDownButtonState();
}

class _SpeedDropDownButtonState extends State<SpeedDropDownButton> {
  String selectedSpeedType = "Feet/s";
  final dropDownFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: dropDownFormKey,
      child: Column(
        children: [
          DropdownButtonFormField(
            value: selectedSpeedType,
            onChanged: (newValue){},
            items: ["Feet/s","Km/hr","Knot","M/s","Miles/hr"].map((e){
              return DropdownMenuItem(child: Text(e),value: e);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
