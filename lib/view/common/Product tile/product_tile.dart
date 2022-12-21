import 'dart:developer';

import 'package:big_mart/controller/cart%20provider/cart_provider.dart';
import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/firebase/auth_firebase.dart';
import 'package:big_mart/controller/const/size/size.dart';
import 'package:big_mart/controller/const/style/Home%20Text/card_text_style.dart';
import 'package:big_mart/model/product%20model/product_models.dart';
import 'package:big_mart/view/cart%20screen/cart%20widget/cart_widget.dart';
import 'package:big_mart/view/common/Add%20Button/add_button.dart';
import 'package:big_mart/view/product%20details/product_screen.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({Key? key, required this.products}) : super(key: key);
 final ProductModel products;
  @override
  Widget build(BuildContext context) {

final cartProvider = Provider.of<CartProvider>(context);

bool isInCart = cartProvider.getCartItems.containsKey(products.id);



    return GestureDetector(
      onTap: () {
        final User? userTile = authInstance.currentUser;

        if (userTile != null) {
          log('user USer');
          log(isInCart.toString());  
          // log(userId);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ProductDetailsScreen(products: products,); 
          },));
          //Navigator.of(context).pushNamed(ProductDetailsScreen.namedRoute);
          return;
        } else {
          log('NO USer');
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            FancyShimmerImage(
              imageUrl: products.imgUrl,
              width: 200,
              height: 110,
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                     
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                      color: greenColour,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                );
              },
            ),
            Container(
              width: 200,
              height: 120,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                  //image: const DecorationImage(image:NetworkImage('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),fit: BoxFit.cover),

                  color: whiteColour,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      products.title,
                      style: cardTextStyle(),
                    ),
                    constHeight10,
                    //  ₹₹₹₹₹ ₹

                    Row(
                      children: [
                        Text(
                          '₹',
                          style: cardCurrencyTextStyle(),
                        ),
                        constWidth5,
                        Text(
                          products.discountPrice.toString(),
                          style: cardRsTextStyle(),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '₹',
                              style: cardCurrencyTextStyle(),
                            ),
                            constWidth5,
                            Text(
                              products.price.toString(),
                              style: markedTextStyle(),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                           !isInCart ? AddButton(  
                            productName: products.title,
                            productPrice: products.discountPrice,  
                              productId: products.id,
                            ) : const AddButton(textTile: 'In Cart',)  
                           ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
