



import 'dart:developer';

import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/favorite%20provider/favorite_provider.dart';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class LikedButton extends StatelessWidget {
  const LikedButton({
    Key? key,
   required this.isliked,
    required this.productId,
     this.id,

  }) : super(key: key);
final bool isliked;
final String productId;
final String? id;
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProider>(context,listen: false);
    return LikeButton(
    
      likeBuilder: (bool like) {
        return GestureDetector(
          onTap: () {
            log('ttttt'); 
             favoriteProvider.addAndRemoveProductOnFavorite(productsId:productId);      
          },
          child: Icon(
            
            Icons.favorite,
            size: 30,
            color: isliked ? greenColour : Colors.grey,          
          ),
        );
      },
      size: 30,
      bubblesColor: BubblesColor(
          dotPrimaryColor: greenColour,
          dotSecondaryColor: greenColour,
          dotLastColor: greenColour,
          dotThirdColor: greenColour),
      circleColor:
          CircleColor(start: greenColour, end: greenColour),
      likeCountAnimationType: LikeCountAnimationType.none,
    );
  }
}
