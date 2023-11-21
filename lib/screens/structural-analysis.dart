import "package:er_desk/widgets/feature-list-builder.dart";
import "package:er_desk/widgets/screen-appbar.dart";
import "package:flutter/material.dart";

class StructuralAnalysis extends StatefulWidget {
  const StructuralAnalysis({super.key});

  @override
  State<StructuralAnalysis> createState() => _StructuralAnalysisState();
}

class _StructuralAnalysisState extends State<StructuralAnalysis> {
  @override
  Widget build(BuildContext context) {
    // fetchItemsInDirectory("structural-analysis");
    return Scaffold(
      appBar: appBar(context, "Structural Analysis"),
      body: Container(
        padding: const EdgeInsets.all(4),
        child: featureListBuilder("structural-analysis")
      ),
    );
  }
}


