


import 'dart:developer';

import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/favorite%20provider/favorite_provider.dart';
import 'package:big_mart/controller/product%20provider/product_provider.dart';
import 'package:big_mart/view/common/App%20Bar/app_bar_common.dart';
import 'package:big_mart/view/favarite/favaroite.dart';



import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LikedScreen extends StatelessWidget {
  const LikedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteProider = Provider.of<FavoriteProider>(context,);   
   
   
    return Scaffold(
      appBar: commonAppBar(titleText: 'Favorites',context: context),  
      body:favoriteProider.getFavoriteItems.isNotEmpty ? ListView.builder(
        
        itemCount: favoriteProider.getFavoriteItems.length,
        itemBuilder: (context, index) {
   
          
           final cartItems =
              favoriteProider.getFavoriteItems.values.toList();
              log(cartItems[index].productId.toString());   
      
              // log(cartItems[index].id.toString());   
          return  
          
          
          
          // Container(
          //   color: greenColour, 
          //   width: double.infinity,
          //   height: 150, 
          //   child: Center(child: Text(cartItems[index].id)), 
          // )
          // ;
  
        FavoritesScreen(favoriteId: cartItems[index].productId,id: cartItems[index].id,);       
        },
      ) : Center(child:Lottie.asset('assets/favorites.json')   
      
      //Lottie.network('https://lottie.host/4bf55400-2c4a-47b1-9a49-24bc6116034a/AWTHQYi7h7.json')
      //Text('Add Items to Favorites Screen',style: TextStyle(color: greenColour),),
      )    
    );
  }
}
