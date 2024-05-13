import "package:er_desk/widgets/screen-appbar.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../utils/conversion-provider.dart";
import "../../widgets/drop-down-button.dart";
import "../../widgets/input-box.dart";

class LengthConversion extends StatelessWidget {
  const LengthConversion({super.key});
  @override
  Widget build(BuildContext context) {
    final lengthUnits = ["km","meter","cm","mm","inch","yard","angul","mile","bitta","haat","kosh","danda","janjir","feet"];
    return ChangeNotifierProvider(
        create: (context)=>ConversionProvider(lengthUnits[0]),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "Poppins"
          ),
          home: Scaffold(
            appBar: appBar(context, "Length Conversion"),
            body: Container(
              padding:const EdgeInsets.all(4),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Expanded(child: InputBox()),
                      const SizedBox(width: 10),
                      Expanded(child: DropDownButton(lengthUnits))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                        itemCount: lengthUnits.length,
                        itemBuilder: (context,index){
                          return Consumer<ConversionProvider>(builder: (context,lengthProvider,_)=>
                              Container(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Text("${LengthConverter.convert(lengthProvider.value, lengthProvider.unit,lengthUnits[index])}"),
                                    ),
                                    Expanded(child: Text(lengthUnits[index]),)
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

class LengthConverter {
  // Conversion rates
  static const double meterToCm = 100;
  static const double meterToKm = 0.001;
  static const double meterToFeet = 3.28084;
  static const double meterToMile = 0.000621371;
  static const double meterToMillimeter = 1000;
  static const double meterToBitta = 1.193033;
  static const double meterToHaat = 0.5965;
  static const double meterToKosh = 0.00032520325203252;
  static const double meterToJanjir = 0.06627959;
  static const double meterToYard = 1.09361;
  static const double meterToInch = 39.3701;
  static const double meterToAngul = 21.474588;
  static const double meterToDanda = 0.149129;

  static double convert(double value,String fromUnit, String toUnit) {
    double resultInMeter;

    // Convert the input value to meters
    switch (fromUnit) {
      case 'meter':
        resultInMeter = value;
        break;
      case "cm":
        resultInMeter = value / meterToCm;
        break;
      case "mm":
        resultInMeter = value / meterToMillimeter;
        break;
      case "km":
        resultInMeter = value / meterToKm;
        break;
      case "feet":
        resultInMeter = value / meterToFeet;
        break;
      case "bitta":
        resultInMeter = value / meterToBitta;
        break;
      case "danda":
        resultInMeter = value / meterToDanda;
        break;
      case "kosh":
        resultInMeter = value / meterToKosh;
        break;
      case "janjir":
        resultInMeter = value / meterToJanjir;
        break;
      case "angul":
        resultInMeter = value / meterToAngul;
        break;
      case "yard":
        resultInMeter = value / meterToYard;
        break;
      case "mile":
        resultInMeter = value / meterToMile;
        break;
      case "inch":
        resultInMeter = value / meterToInch;
        break;
      case "haat":
        resultInMeter = value / meterToHaat;
        break;
      default:
        throw Exception('Unsupported unit: $fromUnit');
    }

    // Convert the value in meters to the target unit
    switch (toUnit) {
      case "meter":
        return resultInMeter;
      case 'cm':
        return resultInMeter * meterToCm;
      case 'km':
        return resultInMeter * meterToKm;
      case 'feet':
        return resultInMeter * meterToFeet;
      case 'mile':
        return resultInMeter * meterToMile;
      case 'mm':
        return resultInMeter * meterToMillimeter;
      case 'bitta':
        return resultInMeter * meterToBitta;
      case 'haat':
        return resultInMeter * meterToHaat;
      case 'kosh':
        return resultInMeter * meterToKosh;
      case 'janjir':
        return resultInMeter * meterToJanjir;
      case 'yard':
        return resultInMeter * meterToYard;
      case 'inch':
        return resultInMeter * meterToInch;
      case 'angul':
        return resultInMeter * meterToAngul;
      case 'danda':
        return resultInMeter * meterToDanda;
      default:
        throw Exception('Unsupported unit: $toUnit');
    }
  }
}
