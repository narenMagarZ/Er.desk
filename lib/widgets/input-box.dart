import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../utils/conversion-provider.dart";

class InputBox extends StatelessWidget {
  const InputBox({super.key});
  @override
  Widget build(BuildContext context) {
    final inputBoxProvider = Provider.of<ConversionProvider>(context,listen: false);
    final TextEditingController controller = TextEditingController(text:"${inputBoxProvider.value}");
    return TextField(
      controller: controller,
      onSubmitted: (value){
        inputBoxProvider.value = double.parse(value);
      },
      keyboardType: TextInputType.number,
    );
  }
}