

import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/size/size.dart';
import 'package:big_mart/controller/const/style/text_style.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

import 'package:flutter/material.dart';

class CategoriesCardWidget extends StatelessWidget {
  const CategoriesCardWidget({
    Key? key,
    required this.categoryTitle,
    required this.imgUrl
  }) : super(key: key);
final String categoryTitle;
final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
     
      width: 135,
      height: 160,
      
      decoration: BoxDecoration(
           color: whiteColour,  
           boxShadow: const [  
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 1.2 ,
                ),
              ], 
 borderRadius: BorderRadius.circular(12),

      ),
      child: Column(
        children: [
          constHeight10,
 SizedBox(
 
  width: 135,
  height: 100 ,
  child:  FancyShimmerImage(
    imageUrl: imgUrl,
    
    imageBuilder: (context, imageProvider) {      
      return CircleAvatar(
      radius: 60 ,
      backgroundImage: imageProvider,);
    },
    
  ),
  ),
// decoration: BoxDecoration(
//   image: const DecorationImage(image: NetworkImage('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),fit: BoxFit.cover),
//   borderRadius: BorderRadius.circular(60),
//    color: greenColour,
// ),
  
constHeight10, 
constHeight10,  
Text(categoryTitle,style: likedCardTextStyle(),),  
        ],
      ),
    ),
      );
  }
}
