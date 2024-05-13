import "package:er_desk/screens/home.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const Home()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white ,
      body: Center(
        child: Image.asset(
          "assets/er-desk.png",
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
