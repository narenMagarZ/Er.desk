import "package:er_desk/widgets/feature-list-builder.dart";
import "package:er_desk/widgets/screen-appbar.dart";
import "package:flutter/material.dart";

class NBCCode extends StatelessWidget {
  const NBCCode({super.key});

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
