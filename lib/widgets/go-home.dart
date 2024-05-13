import "package:er_desk/screens/home.dart";
import "package:flutter/material.dart";


IconButton goHome(BuildContext context){
  return IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));
    }
      );
}