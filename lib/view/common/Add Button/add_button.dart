


import 'dart:developer';

import 'package:big_mart/controller/cart%20provider/cart_provider.dart';
import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/style/text_style.dart';
import 'package:big_mart/view/cart%20screen/cart%20widget/cart_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,this.height,this.width,this.productId,this.textTile, this.productPrice, this.productName 
  }) : super(key: key);
final double? width;
final double? height;
final String? productName;
final String? productId;
final String? textTile;
final num? productPrice;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return GestureDetector(
      onTap: () async{
        log('Add Clickedd $productId'); 

        if(textTile == null){
await cartProvider.addProductsToCartFunction(
  productPrice: productPrice!,
  productId: productId!, itemQuantity: 1); 
cartProvider.fetchUserCartItems(); 
        }else{
showAlertDialogHomeScreen(context: context, itemName: 'sss!');   
          log('Already in cart'); 
        }
         
      },
      child: Container(
        width: width ?? 65,
        height: height ?? 33,
      decoration: BoxDecoration(
          color: greenColour,
          borderRadius: BorderRadius.circular(10)
      ),
        child: Center(child: Text(textTile ?? 'Add',style: addTextStyle(),)), 
      ),
    );
  }
}




