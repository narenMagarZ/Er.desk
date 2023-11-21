import "package:er_desk/screens/about-us.dart";
import "package:er_desk/screens/rate-us.dart";
import "package:flutter/material.dart";
import "package:er_desk/widgets/hero-card.dart";
import 'package:er_desk/widgets/feature-card.dart';
import "package:er_desk/screens/calculator/area-price.dart";
import "package:er_desk/screens/calculator/calculator.dart";
import "package:er_desk/screens/conversion/area.dart";
import "package:er_desk/screens/conversion/length.dart";
import "package:er_desk/screens/conversion/speed.dart";
import "package:er_desk/screens/conversion/temperature.dart";
import "package:er_desk/screens/conversion/weight.dart";
import "package:er_desk/screens/compass.dart";


class Feature {
  String title;
  String svgSrc;
  Feature(this.title,this.svgSrc);
}
class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    List<Feature> features = [
      Feature("Architectural Design", "assets/svg/arch-design.svg"),
      Feature("Home Design", "assets/svg/home-design.svg"),
      Feature("Structural Analysis", "assets/svg/structural-planning.svg"),
      Feature("Valuation", "assets/svg/property-valuation.svg"),
      Feature("NBC Code", "assets/svg/nbc.svg"),
      Feature("Vastru Sastra", "assets/svg/vastu-sastra.svg"),
      Feature("Technical Information", "assets/svg/tech-info.svg"),
      Feature("3d Model", "assets/svg/3d-model.svg")
    ];
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text("Er.Desk",
          style:TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18
          )),
        )
      ),
      drawer: Drawer(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   const Text("Er.Desk",style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF7B5FEB),
                      fontWeight: FontWeight.w600
                  ),
                  ),
                  IconButton(onPressed:(){
                    scaffoldKey.currentState?.openEndDrawer();
                  }, icon: const Icon(Icons.close))
                ],
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    drawerButton(const Home(), Icons.home, "Home",context),
                    drawerButton(const Calculator(), Icons.calculate, "Calculator",context),
                    drawerButton(const AreaPriceCalculator(), Icons.price_change, "Area-Price calculator", context),
                    divider(),
                    sectionHeader("Conversion"),
                    drawerButton(const AreaConversion(), Icons.area_chart,"Area",context),
                    drawerButton(const LengthConversion(), Icons.timeline, "Length",context),
                    divider(),
                    sectionHeader("More"),
                    drawerButton(const Compass(), Icons.compass_calibration, "Compass",context),
                    drawerButton(const TemperatureConversion(), Icons.thermostat, "Temperature",context),
                    drawerButton(const SpeedConversion(), Icons.speed, "Speed",context),
                    drawerButton(const WeightConversion(), Icons.line_weight, "Weight",context),
                    divider(),
                    sectionHeader("About us"),
                    drawerButton(const AboutUs(), Icons.person, "About us",context),
                    drawerButton(const RateUs(), Icons.star_rate, "Rate us",context),

                  ],
                ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: HeroCard(),
            ),
            SliverGrid(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10
            ),
            delegate: SliverChildBuilderDelegate(
                (context,index){
                  return SizedBox(
                      // height: 120,
                      // width: 120,
                      child:FeatureCard(features[index].title,features[index].svgSrc)
                  );
                },
              childCount: 8
            ),
            )
          ],
        )
      ),
    );
  }
}

void closeDrawer(GlobalKey<ScaffoldState> scaffoldKey){
  scaffoldKey.currentState?.openEndDrawer();
}
TextButton drawerButton(fn,icon,label,context){
  return TextButton.icon(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> fn));
      },
      icon: Icon(icon),
      label: Text(label,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.black
      ),
      )
  );
}

Divider divider(){
  return const Divider(
    thickness: 1,
  );
}

Container sectionHeader(title){
  return Container(
    padding: const EdgeInsets.all(4),
    child: Text(title,
    style: const TextStyle(

    ),
    ),
  );
}
