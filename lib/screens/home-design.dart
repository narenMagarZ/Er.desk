import "package:flutter/material.dart";
import "package:er_desk/widgets/screen-appbar.dart";
class HomeDesign extends StatefulWidget {
  const HomeDesign({super.key});

  @override
  State<HomeDesign> createState() => _HomeDesignState();
}

class _HomeDesignState extends State<HomeDesign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context,"Home Design"),
      body: Container(),
    );
  }
}
