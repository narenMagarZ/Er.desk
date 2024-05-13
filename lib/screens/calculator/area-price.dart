import "package:er_desk/widgets/screen-appbar.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
class AreaPriceCalculator extends StatelessWidget {
  const AreaPriceCalculator({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=>AreaPriceProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "Poppins"
          ),
          home: Scaffold(
            appBar: appBar(context, "Area-price Calculator"),
            body: Container(
              padding: const EdgeInsets.all(4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const AreaField(),
                  const RateField(),
                  Consumer<AreaPriceProvider>(builder: (context,provider,_)=>
                      TextField(
                        enabled: false,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          prefixText: "Total rate: "
                        ),
                        controller: TextEditingController(text:"${provider.totalRate}"),
                      )
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}

class AreaField extends StatelessWidget{
  const AreaField({super.key});
  @override
  Widget build(context){
    final provider = Provider.of<AreaPriceProvider>(context,listen: false);
    return TextField(
      onChanged: (newValue){
        provider.area = newValue==""?0:double.parse(newValue);
        provider.totalRate = calculatePrice(provider.area, provider.perAreaRate);
      },
      decoration: const InputDecoration(
        hintText: "Area value"
      ),
      keyboardType: TextInputType.number,
    );
  }
}
class RateField extends StatelessWidget{
  const RateField({super.key});
  @override
  Widget build(context){
    final provider = Provider.of<AreaPriceProvider>(context,listen: false);
    return TextField(
      onChanged: (newValue){
        provider.perAreaRate = newValue==""?0:double.parse(newValue);
        provider.totalRate = calculatePrice(provider.area, provider.perAreaRate);
      },
      decoration: const InputDecoration(
        hintText: "Rate per area"
      ),
      keyboardType: TextInputType.number,
    );
  }
}


class AreaPriceProvider extends ChangeNotifier {
  double _area = 0;
  double _perAreaRate = 0;
  double _totalRate = 0;

  double get area=>_area;
  double get perAreaRate=>_perAreaRate;
  double get totalRate=>_totalRate;

  set area(double newArea){
    _area=newArea;
    notifyListeners();
  }
  set totalRate(double newTotalRate){
    _totalRate=newTotalRate;
    notifyListeners();
  }
  set perAreaRate(double newPerAreaRate){
    _perAreaRate=newPerAreaRate;
    notifyListeners();
  }
}

double calculatePrice(double area,double ratePerArea)=>area * ratePerArea;

