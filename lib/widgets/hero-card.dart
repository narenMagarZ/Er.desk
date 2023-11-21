import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

class HeroCard extends StatelessWidget {
  const HeroCard({super.key});
  @override
  Widget build(BuildContext context){
    final Widget hero = SvgPicture.asset("assets/svg/app-hero.svg");
    return SizedBox(
      height: 120,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 120,
        padding: const EdgeInsets.all(8),
        decoration:  BoxDecoration(
            color: const Color(0xFF7B5FEB),
            borderRadius:  BorderRadius.circular(4)
        ),
        child:  Row(
          children: [
             const SizedBox(
               width: 200,
              child: Text("The Blueprint To Your Imagination",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              )),
            ),
            SizedBox(
              height: 120,
              width: 120,
              child: hero,
            )
          ],
        ),
      )
    );

  }
}