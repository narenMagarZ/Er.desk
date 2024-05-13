import "package:er_desk/widgets/screen-appbar.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../../utils/conversion-provider.dart";
import "../../widgets/drop-down-button.dart";
import "../../widgets/input-box.dart";

class AreaConversion extends StatelessWidget {
  const AreaConversion({super.key});

  @override
  Widget build(BuildContext context) {
    final areaUnits = ["bigha","kattha","dhur","ropani","aana","paisa","daam","sq.meter","sq.feet","khetmuri","matomuri","acre","hectare"];
    return ChangeNotifierProvider(
      create: (context)=>ConversionProvider(areaUnits[0]),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins'
        ),
        home: Scaffold(
          appBar: appBar(context, "Area Conversion"),
          body: Container(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Expanded(child: InputBox()),
                    const SizedBox(width: 10),
                    Expanded(child: DropDownButton(areaUnits))
                  ],
                ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(4),
                        itemCount: areaUnits.length,
                        itemBuilder: (context,index){
                          return Consumer<ConversionProvider>(builder: (context,provider,_)=>
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(child:Text("${convertArea(provider.value, provider.unit,areaUnits[index] )}")),
                                Expanded(child: Text(areaUnits[index]))
                              ],
                            ),
                          ));
                        }
                    ),
                  ) ,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

double convertArea(double value, String sourceUnit, String targetUnit) {
  const squareMeterToSquareFeet = 10.764;
  double convertToSquareMeter(double inputValue, String unit) {
    switch (unit) {
      case "bigha":
        return inputValue * 6772.41;
      case "kattha":
        return inputValue * 338.62 ;
      case "dhur":
        return inputValue * 16.93;
      case "ropani":
        return inputValue * 508.74;
      case "aana":
        return inputValue * 31.80;
      case "paisa":
        return inputValue * 7.95;
      case "daam":
        return inputValue * 1.99 ;
      case "sq.meter":
        return inputValue;
      case "sq.feet":
        return inputValue / squareMeterToSquareFeet;
      case "khetmuri":
        return inputValue * 12718.5 ;
      case "matomuri":
        return inputValue * 127.185;
      case "acre":
        return inputValue * 4046.86;
      case "hectare":
        return inputValue * 10000;
      default:
        throw Exception("Unsupported unit: $targetUnit");
    }
  }

  double convertFromSquareMeter(double inputValue, String unit) {
    switch (unit) {
      case "bigha":
        return inputValue / 6772.41 ;
      case "kattha":
        return inputValue / 338.62;
      case "dhur":
        return inputValue / 16.93;
      case "ropani":
        return inputValue / 508.74;
      case "aana":
        return inputValue / 31.80;
      case "paisa":
        return inputValue / 7.95;
      case "daam":
        return inputValue / 1.99;
      case "sq.meter":
        return inputValue ;
      case "sq.feet":
        return inputValue * squareMeterToSquareFeet;
      case "khetmuri":
        return inputValue / 12718.5 ;
      case "matomuri":
        return inputValue /  127.185;
      case "acre":
        return inputValue / 4046.86;
      case "hectare":
        return inputValue / 10000;
      default:
        throw Exception("Unsupported unit: $targetUnit");
    }
  }

  double valueInSquareMeter = convertToSquareMeter(value, sourceUnit);
  return convertFromSquareMeter(valueInSquareMeter, targetUnit);
}

