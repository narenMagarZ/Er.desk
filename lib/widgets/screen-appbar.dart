import "package:flutter/material.dart";

AppBar appBar(context,title){
  final screenWithTabs = ["Architectural Design"];
  return screenWithTabs.contains(title) ?
    AppBar(
      leading: backButton(context),
      backgroundColor: const Color(0xFF7B5FEB),
      title: Center(
          child:screenTitle(title)
      ),
      bottom: TabBar(
        indicatorColor: Colors.white,
        // indicatorPadding: const EdgeInsets.all(4),
        tabs: [
          Container(
            padding: const EdgeInsets.all(4),
            child: const Text("Basic Design"),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            child: const Text("Detail Design"),
          )
        ],
      ),
  ) : AppBar(
    leading: backButton(context),
    backgroundColor: const Color(0xFF7B5FEB),
    title: Center(
      child:screenTitle(title)),
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