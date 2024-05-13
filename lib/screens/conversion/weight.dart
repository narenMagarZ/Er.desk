import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../../utils/conversion-provider.dart";
import "../../widgets/drop-down-button.dart";
import "../../widgets/input-box.dart";
import "../../widgets/screen-appbar.dart";

class WeightConversion extends StatelessWidget {
  const WeightConversion({super.key});

  @override
  Widget build(BuildContext context) {
    final units = ["g","kg","mg","pound","tonne","quintal","dharni","chatak","ounce","pau"];
    return ChangeNotifierProvider(
      create: (context)=>ConversionProvider(units[0]),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: "Poppins"
        ),
        home: Scaffold(
          appBar: appBar(context, "Weight Conversion"),
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
                      itemCount: 9,
                      itemBuilder: (context,index){
                        return Consumer<ConversionProvider>(builder: (context,weightProvider,_)=>
                            Container(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Text("${convertWeight(weightProvider.value, weightProvider.unit,units[index])}"),
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
    );;
  }
}

// class WeightConverter {
  // Conversion rates
   const double dharniToKg = 2.32;
   const double chatakToKg = 0.05831;
   const double poundToKg = 0.453592;
   const double pauToKg = 0.249476;
   const double ounceToKg = 0.0283495;

   double convertWeight(double value,String fromUnit, String toUnit) {
    double resultInKg;

    // Convert the input value to kilograms
    switch (fromUnit) {
      case 'dharni':
        resultInKg = value * dharniToKg;
        break;
      case 'chatak':
        resultInKg = value * chatakToKg;
        break;
      case 'pound':
        resultInKg = value * poundToKg;
        break;
      case 'pau':
        resultInKg = value * pauToKg;
        break;
      case 'ounce':
        resultInKg = value * ounceToKg;
        break;
      case 'kg':
        resultInKg = value;
        break;
      case 'g':
        resultInKg = value / 1e3;
        break;
      case "mg":
        resultInKg = value / 1e6;
        break;
      case 'tonne':
        resultInKg = value * 1e3;
      case 'quintal':
        resultInKg = value * 100;
        break;
      default:
        throw Exception('Unsupported unit: $fromUnit');
    }

    // Convert the value in kilograms to the target unit
    switch (toUnit) {
      case 'dharni':
        return resultInKg / dharniToKg;
      case 'chatak':
        return resultInKg / chatakToKg;
      case 'pound':
        return resultInKg / poundToKg;
      case 'pau':
        return resultInKg / pauToKg;
      case 'ounce':
        return resultInKg / ounceToKg;
      case 'kg':
        return resultInKg;
      case 'mg':
        return resultInKg * 1e6;
      case 'g':
        return resultInKg * 1e3;
      case 'tonne':
        return resultInKg / 1e3;
      case 'quintal':
        return resultInKg / 100;
      default:
        throw Exception('Unsupported unit: $toUnit');
    }
  }
// }

