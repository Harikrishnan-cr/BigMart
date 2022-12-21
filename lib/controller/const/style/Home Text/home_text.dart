import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/view/search_screen/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Padding headText({required String headTitle,context}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(headTitle,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 22, color: blackColour)),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder:  (context) => SearchScreen(),));
          },
          child: Container(
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: greyBacground,
            ),
            height: 25,
            child: const Center(child: Text('View All')),
          ),
        )
      ],
    ),
  );
}



  //SearchScreen

