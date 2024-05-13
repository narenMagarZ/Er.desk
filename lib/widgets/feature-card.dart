import "package:er_desk/screens/3d-model-viewer.dart";
import 'package:er_desk/screens/arch-design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "package:er_desk/screens/arch-design.dart";
import "package:er_desk/screens/home-design.dart";
import "package:er_desk/screens/structural-analysis.dart";
import "package:er_desk/screens/technical-info.dart";
import "package:er_desk/screens/valuation.dart";
import "package:er_desk/screens/vastru-sastra.dart";
import "package:er_desk/screens/nbc-code.dart";
import "package:er_desk/screens/3d-model.dart";
class FeatureCard extends StatelessWidget {
  final String title;
  final String svgSrc;
  const FeatureCard(this.title,this.svgSrc,{super.key});
  @override
  Widget build(BuildContext context) {
    final Widget svg = SvgPicture.asset(
      svgSrc,
      height: 30,
      width: 30,
      semanticsLabel: title);
    final Map<String,Widget> dests =  {
      "Architectural Design": const ArchitecturalDesign(),
      "Home Design":const HomeDesign(),
      "Structural Analysis":const StructuralAnalysis(),
      "Valuation":const Valuation(),
      "NBC Code":const NBCCode(),
      "Vastru Sastra":const VastruSastra(),
      "Technical Information":const TechnicalInfo(),
      "3d Model":const ThreeDModel()
    };
    return LayoutBuilder(
      builder: (context, snapshot) {
        return InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>dests[title]!));
          },
          child: SizedBox(
            width: snapshot.maxWidth / 2 - 10,
            height: snapshot.maxHeight / 2 -10,
            child: Container(
              decoration:  BoxDecoration(
                color: const Color(0x087B5FEB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    svg,
                    const SizedBox(height: 6),
                    Text(title,textDirection: TextDirection.ltr,style: const TextStyle(
                      fontSize: 11
                    ),)
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
