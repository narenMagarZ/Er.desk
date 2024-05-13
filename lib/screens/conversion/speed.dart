import "package:er_desk/widgets/screen-appbar.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../../utils/conversion-provider.dart";
import "../../widgets/drop-down-button.dart";
import "../../widgets/input-box.dart";
class SpeedConversion extends StatelessWidget {
  const SpeedConversion({super.key});
  @override
  Widget build(BuildContext context) {
    final speedUnits = [
      "feet/s",
      "m/s",
      "km/hr",
      "miles/hr"
    ];
    return ChangeNotifierProvider(
      create: (context)=>ConversionProvider(speedUnits[0]),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Poppins"
        ),
        home: Scaffold(
          appBar: appBar(context, "Speed Conversion"),
          body: Container(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Expanded(
                      child: InputBox()
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                     child: DropDownButton(speedUnits),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: speedUnits.length,
                    itemBuilder: (context,index){
                      return Consumer<ConversionProvider>(
                        builder: (context,speed,_)=>Container(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(child: Text("${convertSpeed(speed.value, speed.unit, speedUnits[index])}")),
                              Expanded(child: Text(speedUnits[index]))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


double convertSpeed(double value, String from, String to) {
  double speedInMetersPerSecond;
  // Convert the input speed to meters per second
  if (from == "feet/s") {
    speedInMetersPerSecond = value * 0.3048;
  } else if (from == "km/hr") {
    speedInMetersPerSecond = value * 1000 / 3600;
  } else if (from == "miles/hr") {
    speedInMetersPerSecond = value * 1609.34 / 3600;
  } else {
    speedInMetersPerSecond = value;
  }

  // Convert the speed in meters per second to the target unit
  if (to == "feet/s") {
    return speedInMetersPerSecond / 0.3048;
  } else if (to == "km/hr") {
    return speedInMetersPerSecond * 3600 / 1000;
  } else if (to == "miles/hr") {
    return speedInMetersPerSecond * 3600 / 1609.34;
  } else {
    return speedInMetersPerSecond;
  }
}
