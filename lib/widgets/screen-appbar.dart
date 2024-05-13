import "package:flutter/material.dart";

AppBar appBar(context,title){
  return AppBar(
    centerTitle: true,
    leading: backButton(context),
    backgroundColor: const Color(0xFF7B5FEB),
    title: screenTitle(title),
  ) ;
}

BackButton backButton(context)=>BackButton(
  onPressed: ()=>Navigator.pop(context),
  style: const ButtonStyle(
    iconSize: MaterialStatePropertyAll(18),
    iconColor: MaterialStatePropertyAll(Colors.white)
  ),
);
Text screenTitle(title)=>Text(title,
  style: const TextStyle(
    // fontWeight: FontWeight.w600,
    fontSize: 16,
    color: Colors.white
    )
);