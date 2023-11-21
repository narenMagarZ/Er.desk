import "package:er_desk/widgets/feature-list-builder.dart";
import "package:er_desk/widgets/screen-appbar.dart";
import "package:flutter/material.dart";

class NBCCode extends StatefulWidget {
  const NBCCode({super.key});

  @override
  State<NBCCode> createState() => _NBCCodeState();
}

class _NBCCodeState extends State<NBCCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "NBC Code"),
      body: Container(
        padding: const EdgeInsets.all(4),
        child: featureListBuilder("NBC-code")
      ),
    );
  }
}
