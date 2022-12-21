import 'package:big_mart/controller/const/color/colours.dart';

import 'package:flutter/material.dart';

TextStyle optionStyle() =>
    TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: blackColour);

TextStyle appBarCartStyle() =>
    TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: whiteColour);
TextStyle addTextStyle() =>
    TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: whiteColour);  

TextStyle likedCardTextStyle() =>
    TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: blackColour  );



TextStyle reviewCardTextStyle() =>
    TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: blackColour);  

    TextStyle reviewRsTextStyle() =>
    TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: blackColour);   



   TextStyle userScreenTextStyle() => TextStyle(
                    color: blackColour,
                    fontSize: 18 ,
                    fontWeight: FontWeight.bold);
TextStyle userScreenSecondaryTextStyle() => const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500);




                     TextStyle userScreenCardTextStyle() => TextStyle(
                    color: blackColour,
                    fontSize: 18,
                    fontWeight: FontWeight.bold);
TextStyle userScreenSecondaryCardTextStyle() => const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500);



                       TextStyle productScreenTextStyle() => TextStyle(
                    color: blackColour,
                    fontSize: 22 ,
                    fontWeight: FontWeight.bold);




                    TextStyle loginUserScreenSecondaryCardTextStyle() => const TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                    fontWeight: FontWeight.w400);




                    TextStyle userLoginTextStyle() => TextStyle(fontWeight: FontWeight.bold,color: greenColour,fontSize: 16);