import "package:er_desk/widgets/feature-list-builder.dart";
import "package:er_desk/widgets/screen-appbar.dart";
import "package:flutter/material.dart";


class VastruSastra extends StatefulWidget {
  const VastruSastra({super.key});

  @override
  State<VastruSastra> createState() => _VastruSastraState();
}

class _VastruSastraState extends State<VastruSastra> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Vastru Sastra"),
      body: Container(
        padding: const EdgeInsets.all(4),
        child: featureListBuilder("vastu-sastra"),
      ),
    );
  }
}
