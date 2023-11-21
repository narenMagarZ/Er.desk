import "package:er_desk/widgets/screen-appbar.dart";
import "package:flutter/material.dart";
import "package:er_desk/widgets/feature-list-builder.dart";


class Valuation extends StatefulWidget {
  const Valuation({super.key});

  @override
  State<Valuation> createState() => _ValuationState();
}

class _ValuationState extends State<Valuation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Valuation"),
      body: Container(
        padding: const EdgeInsets.all(4),
        child: featureListBuilder("valuation"),
      ),
    );
  }
}
