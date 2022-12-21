import 'dart:developer';

import 'package:big_mart/controller/cart%20provider/cart_provider.dart';
import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/size/size.dart';
import 'package:big_mart/controller/const/style/Home%20Text/card_text_style.dart';
import 'package:big_mart/controller/product%20provider/product_provider.dart';
import 'package:big_mart/model/cart%20model/cart_model.dart';

import 'package:big_mart/view/cart%20screen/cart%20widget/add_cart_widget.dart';
import 'package:big_mart/view/common/address/addadress.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreenCard extends StatelessWidget {
  const CartScreenCard({Key? key, required this.cartModel}) : super(key: key);
  final CartModel cartModel;
  final String subtraction = '-';
  @override
  Widget build(BuildContext context) {
    log('rebuild ui');
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    final productsProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final items =
        productsProvider.findProductById(productId: cartModel.productId);
    return Padding(
      padding: const EdgeInsets.all(12),
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
                      child: Text(
                        items.title,
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
                          SizedBox(
                            width: 150,
                            child: Text(
                              '${items.discountPrice * cartModel.productQuantity}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: greenColour,
                                  fontSize: 20,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      constWidth10,
                    ],
                  ),
                  constHeight10,
                  Text(
                    '${cartModel.productQuantity.toString()} Pack',
                    style: packAndKiloTextStyle(),
                  ),
                  constHeight10,
                  // const LikedButton()
                  GestureDetector(
                    onTap: () {
                      showAlertDialogCartScreen(
                          context: context,
                          itemName: items.title,
                          cartModel: cartModel,
                          cartProvider: cartProvider);
                      log('remove pressed');
                     
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.delete_sweep_sharp,
                          size: 15,
                        ),
                        constWidth5,
                        Text(
                          'Remove',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 3, left: 0),
              child: Column(
                children: [
                  FancyShimmerImage(
                    imageUrl: items.imgUrl,
                    width: 120,
                    height: 80,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(12)),
                      );
                    },
                  ),
                  constHeight10,
                  constHeight5,
                  Row(children: [
                    GestureDetector(
                        onTap: () {
                          // Navigator.pushReplacementNamed(context, CartScreen.routName);
                          if (cartModel.productQuantity >= 2) {
                            cartProvider.reduceQuantityByOne(
                              productPrice: items.discountPrice,
                                productId: cartModel.productId,
                                id: cartModel.id,
                                productQuantity: cartModel.productQuantity);
                          } else if (cartModel.productQuantity == 1) {
                            showAlertDialogCartScreen(
                                context: context,
                                itemName: items.title,
                                cartModel: cartModel,
                                cartProvider: cartProvider);
                            //cartProvider.removeItem(productId: cartModel.productId,productQuantity: cartModel.productQuantity,id: cartModel.id);
                          }
                        },
                        child: const AddItemsWidget(subtraction: '–')),
                    constWidth5,
                    constWidth5,
                    Consumer<CartProvider>(builder: (context, cartProvider, _) {
                      return Text(
                        cartModel.productQuantity.toString(),
                        style: cardTextStyle(),
                      );
                    }),
                    constWidth5,
                    constWidth5,
                    GestureDetector(
                        onTap: () {
                          log('add pressed');

                          cartProvider.increaseQuantityByOne(
                              productId: cartModel.productId,
                              productPrice: items.discountPrice, 
                              productQuantity: cartModel.productQuantity,
                              id: cartModel.id);
                        },
                        child: const AddItemsWidget(subtraction: '+')),
                  ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

showAlertDialogCartScreen(
    {required BuildContext context,
    required String itemName,
    required CartModel cartModel,
    required CartProvider cartProvider}) {
  Widget cancelButton = TextButton(
    child: Text(
      "Cancel",
      style: TextStyle(color: blackColour, fontWeight: FontWeight.w500),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Continue",
        style: TextStyle(color: greenColour, fontWeight: FontWeight.w500)),
    onPressed: () {
      cartProvider.removeItem(
          productId: cartModel.productId,
          productQuantity: cartModel.productQuantity,
          id: cartModel.id);
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Remove Item From Cart",
        style: TextStyle(color: greenColour, fontWeight: FontWeight.w500)),
    content: Text("$itemName Will be removed from your cart?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}





showAlertDialogHomeScreen(
    {required BuildContext context,
    required String itemName,
   }) {
  Widget cancelButton = TextButton(
    child: Text(
      "Cancel",
      style: TextStyle(color: blackColour, fontWeight: FontWeight.w500),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Continue",
        style: TextStyle(color: greenColour, fontWeight: FontWeight.w500)),
    onPressed: () {
     
    Navigator.of(context).pop();  
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Already In Cart",
        style: TextStyle(color: greenColour, fontWeight: FontWeight.w500)),
    content: const Text("Item is Already in the Cart!"), 
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}





showAlertDialogCommonScreen(
    {required BuildContext context,
    required String itemContent,
    required String itemHead,
    
   }) {
  Widget cancelButton = TextButton(
    child: Text(
      "Cancel",
      style: TextStyle(color: blackColour, fontWeight: FontWeight.w500),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Continue",
        style: TextStyle(color: greenColour, fontWeight: FontWeight.w500)),
    onPressed: () {
      
    Navigator.of(context).pop();  
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(itemHead,
        style: TextStyle(color: greenColour, fontWeight: FontWeight.w500)),
    content:  Text(itemContent), 
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}