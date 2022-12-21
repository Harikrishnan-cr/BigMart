import 'package:big_mart/controller/cart%20provider/cart_provider.dart';
import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/size/size.dart';
import 'package:big_mart/controller/const/style/Home%20Text/card_text_style.dart';
import 'package:big_mart/controller/favorite%20provider/favorite_provider.dart';

import 'package:big_mart/model/product%20model/product_models.dart';
import 'package:big_mart/view/common/Add%20Button/add_button.dart';
import 'package:big_mart/view/common/liked%20button/liked_button.dart';
import 'package:big_mart/view/product%20details/product_screen.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreenCard extends StatelessWidget {
   const FavoritesScreenCard({
    Key? key,
   required this.products,
 this.index
  }) : super(key: key);
final ProductModel products;
final int? index;
  @override
  Widget build(BuildContext context) {
     final cartProvider = Provider.of<CartProvider>(context);

     final favoriteProider = Provider.of<FavoriteProider>(context);

bool isLiked = favoriteProider.getFavoriteItems.containsKey(products.id);

bool isInCart = cartProvider.getCartItems.containsKey(products.id);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ProductDetailsScreen(products: products,);  
          },));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: whiteColour,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          width: double.infinity,
          height: 150,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 190,
                        child: Text(products.title ,
                      
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: blackColour),
                          overflow: TextOverflow.ellipsis,
                        )),
                    constHeight10,
                    Row(
                      children: [
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
                        constWidth10,
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
                        )
                      ],
                    ),
                    constHeight10,
                    Text( 
                      '1 Pack',      
                      style: packAndKiloTextStyle(),
                    ),
                    constHeight10,
                     LikedButton(productId: products.id, isliked: isLiked,)  
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 3, left: 0),
                child: Column(
                  children: [
      
                    FancyShimmerImage(imageUrl: products.imgUrl,
                     width: 120,
                      height: 80,  
                    imageBuilder: (context, imageProvider) { 
                      
                      return  Container(
                     
                      decoration: BoxDecoration(
                          image:  DecorationImage(   
                              image:imageProvider,fit: BoxFit.cover ),
                          borderRadius: BorderRadius.circular(12)),
                    );
                    },
                    ),
                  
                    constHeight10,
                    constHeight5,
                    !isInCart ?  AddButton(
                      productName: products.title,
                      productPrice: products.discountPrice,
                      productId: products.id, 
                      width: 100,
                      height: 35,
                    ): const AddButton(
                       width: 100,
                      height: 35,
                      textTile: 'In Cart',   
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
