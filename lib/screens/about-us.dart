import "package:er_desk/widgets/screen-appbar.dart";
import "package:flutter/material.dart";


class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    const String aboutUsInfo = "";
    return Scaffold(
      appBar: appBar(context, "About us"),
      body: Container(
        padding: const EdgeInsets.all(4),
        child: const Center(
          child: Text(aboutUsInfo)
        ),
      ),
    );
  }
}
