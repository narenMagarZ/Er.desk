import "package:er_desk/widgets/screen-appbar.dart";
import "package:flutter/material.dart";


class TechnicalInfo extends StatefulWidget {
  const TechnicalInfo({super.key});

  @override
  State<TechnicalInfo> createState() => _TechnicalInfoState();
}

class _TechnicalInfoState extends State<TechnicalInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Technical Information"),
    );
  }
}
