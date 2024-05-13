import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../utils/conversion-provider.dart";
class DropDownButton extends StatelessWidget {
  final List units;
  const DropDownButton(this.units,{super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final dropdownButtonProvider = Provider.of<ConversionProvider>(context,listen: false);
    return Form(
      key: formKey,
      child: Column(
        children: [
          DropdownButtonFormField(
              value: dropdownButtonProvider.unit,
              items: units.map((unit){
                return DropdownMenuItem(
                  value:unit,
                  child: Text("$unit"),
                );
              }).toList(),
              onChanged: (newValue){
                dropdownButtonProvider.unit = newValue;
              })
        ],
      ),
    );
  }
}
