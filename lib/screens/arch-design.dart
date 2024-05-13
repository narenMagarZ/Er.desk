import "package:flutter/material.dart";
import "package:er_desk/widgets/screen-appbar.dart";
import "../widgets/feature-list-builder.dart";
class ArchitecturalDesign extends StatefulWidget {
  const ArchitecturalDesign({super.key});

  @override
  State<ArchitecturalDesign> createState() => _ArchitecturalDesignState();
}

class _ArchitecturalDesignState extends State<ArchitecturalDesign> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins'
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: appBar(context,"Architectural Design"),
          body: Container(
              padding: const EdgeInsets.all(4),
              child: featureListBuilder("architectural-design")
          ),
        ),
      ),
    );
  }
}



