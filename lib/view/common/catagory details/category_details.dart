



import 'dart:developer';

import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/style/Home%20Text/card_text_style.dart';

import 'package:big_mart/controller/product%20provider/product_provider.dart';
import 'package:big_mart/model/product%20model/product_models.dart';

import 'package:big_mart/view/likes%20screen/liked%20widget/liked_screen_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

class CatagoryDetailsScreen extends StatelessWidget {
  const CatagoryDetailsScreen({Key? key,required this.ctaName}) : super(key: key);
final String ctaName;
  @override
  Widget build(BuildContext context) {
    log(ctaName); 
    final productsProvider =
        Provider.of<ProductProvider>(context, listen: false);
     List<ProductModel> ctalist =   productsProvider.findProductByCatagoryName(ctaName);     
        int listLength = ctalist.length;
        log(listLength.toString()); 
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector( 
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: blackColour,
              )),
          toolbarHeight: 70,
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            ctaName, 
            style: cardCurrencyTextStyle(),
          ),
        ),
      body:  listLength != 0 ?
      
      
      ListView.builder(  
        itemCount: listLength,
        scrollDirection: Axis.vertical, 
        itemBuilder: (context, index) {   
        return FavoritesScreenCard(products: ctalist[index],);  
        
      },) : Center(child: Container(

        child:Lottie.asset('assets/catagory.json'),     
      ),)
      
    
      
      
    
    );
  }
}


//  GridView.count(crossAxisCount: 2, scrollDirection: Axis.vertical, 
//       children: List.generate(1, (index) => ProductTile(products: ctalist[index])), 
//       ),
///
///
///