import "package:er_desk/widgets/screen-appbar.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../../utils/conversion-provider.dart";
import "../../widgets/drop-down-button.dart";
import "../../widgets/input-box.dart";

class TemperatureConversion extends StatelessWidget {
  const TemperatureConversion({super.key});

  @override
  Widget build(BuildContext context) {
    final units = ["celsius","fahrenheit","kelvin"];
    return ChangeNotifierProvider(
      create: (context) =>ConversionProvider(units[0]),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Poppins"
        ),
        home: Scaffold(
          appBar: appBar(context, "Temperature Conversion"),
          body: Container(
            padding:const EdgeInsets.all(4),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Expanded(child: InputBox()),
                    const SizedBox(width: 10),
                    Expanded(child: DropDownButton(units))
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context,index){
                        return Consumer<ConversionProvider>(builder: (context,temperature,_)=>
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Text("${convertTemperature(temperature.value, temperature.unit,units[index])}"),
                              ),
                              Expanded(
                                child: Text(units[index]),
                              )
                            ],
                          ),
                        )
                        );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

double convertTemperature(double value, String from, String to) {
  double tempInCelsius;
  // Convert the input temperature to Celsius
  if (from == "fahrenheit") {
    tempInCelsius = (value - 32) * 5 / 9;
  } else if (from == "kelvin") {
    tempInCelsius = value - 273.15;
  } else {
    tempInCelsius = value;
  }

  // Convert the temperature in Celsius to the target unit
  if (to == "fahrenheit") {
    return tempInCelsius * 9 / 5 + 32;
  } else if (to == "kelvin") {
    return tempInCelsius + 273.15;
  } else {
    return tempInCelsius;
  }
}

