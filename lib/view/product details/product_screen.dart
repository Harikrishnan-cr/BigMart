

import 'dart:developer';

import 'package:big_mart/controller/cart%20provider/cart_provider.dart';
import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/size/size.dart';
import 'package:big_mart/controller/const/style/Home%20Text/card_text_style.dart';
import 'package:big_mart/controller/const/style/text_style.dart';
import 'package:big_mart/controller/favorite%20provider/favorite_provider.dart';
import 'package:big_mart/model/product%20model/product_models.dart';
import 'package:big_mart/view/common/Add%20Button/add_button.dart';
import 'package:big_mart/view/common/cart%20bottom%20bar/cart_bottom_bar.dart';
import 'package:big_mart/view/common/liked%20button/liked_button.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const namedRoute = "/ProductDetailedScreen";
  ProductDetailsScreen({Key? key,required this.products,this.index}) : super(key: key);
  final dynamic productIcon = Icon(
    Icons.arrow_back_rounded,
    color: whiteColour,
    
  );
final int? index;
   final ProductModel products;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    // final favoriteProvider = Provider.of<FavoriteProider>(context);

        final favoriteProider = Provider.of<FavoriteProider>(context);

bool isLiked = favoriteProider.getFavoriteItems.containsKey(products.id);

bool isInCart = cartProvider.getCartItems.containsKey(products.id);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FancyShimmerImage(imageUrl: products.imgUrl,
              width: double.infinity, 
            imageBuilder: (context, imageProvider) {
              return Container(
            
              height: 250,
              decoration:  BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover)),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(); 
                          },
                          child: ProductAppBarIcon(productIcon: productIcon))],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 21,
                            backgroundColor: greyBacground,
                            child:  Padding(
                              padding: const EdgeInsets.only(left: 3, top: 1),
                              child: LikedButton(productId: products.id,isliked: isLiked,),
                            ),
                          ),
                          constWidth10,
                          ProductAppBarIcon(
                              productIcon: Icon(
                            Icons.share,
                            color: whiteColour,
                          )),
                          constWidth10,
                          constWidth10,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
            },
            ),
            constHeight10,
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                products.title,
                style: productScreenTextStyle(),
              ),
            ),
            constHeight10,
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: productScreenTextStyle(),
                  ),
                  constHeight10,
                  Text(
                    products.description,
                    style: likedCardTextStyle(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        color: greenProductScreen,
        height: 90,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '₹',
                    style: productRsTextStyle(),
                  ),
                  constWidth5,
                  Text(
                    products.discountPrice.toString(),
                    style: productRsTextStyle(),
                  ),
                ],
              ),
              Row(
                children:  [  
                 !isInCart ? AddButton(
                  productName: products.title,
                  productPrice: products.discountPrice,
                    productId: products.id, 
                    height: 40, 
                    width: 85,
                  ) : AddButton(textTile: 'In Cart',  height: 40, 
                    width: 85,)
                ],
              )
            ],
          ),    
        ),
      ),
   //  bottomSheet: CartScreenBottomBar(cartCount: cartProvider.getCartItems.length,totalPrice: cartTotal,),       
    );
  }
}

class ProductAppBarIcon extends StatelessWidget {
  const ProductAppBarIcon({
    Key? key,
    required this.productIcon,
  }) : super(key: key);

  final Icon productIcon;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 21,
      child: productIcon,
      backgroundColor: greyBacground,
    );
  }
}
