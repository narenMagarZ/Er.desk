import "package:flutter/material.dart";

class ListCard extends StatelessWidget {
  final String imgSrc ;
  final String title;
  const ListCard(this.imgSrc,this.title,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

        ],
      ),
    );
  }
}
