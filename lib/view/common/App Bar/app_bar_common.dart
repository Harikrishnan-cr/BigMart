import 'dart:developer';

import 'package:big_mart/controller/cart%20provider/cart_provider.dart';
import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/size/size.dart';
import 'package:big_mart/controller/const/style/Home%20Text/card_text_style.dart';
import 'package:big_mart/controller/const/style/text_style.dart';
import 'package:big_mart/view/cart%20screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AppBar commonAppBar({String? titleText, context}) {
  //  final cartProvider = Provider.of<CartProvider>(context, listen: false);

  return AppBar(
    toolbarHeight: 70,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      titleText.toString(),
      style: cardCurrencyTextStyle(),
    ),
    centerTitle: true,
    actions: [
      Stack(
        children: [
          GestureDetector(
            onTap: () {
              log('pressed cart');

              Navigator.pushNamed(context, CartScreen.routName);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 3),
              child: Icon(
                Icons.shopping_cart,
                color: blackColour,
                size: 30,
              ),
            ),
          ),
          Consumer<CartProvider>(builder: (context, cartProvider, _) {
            final cartItems = cartProvider.getCartItems.values.toList();
            return Positioned(
                top: 12,
                left: 18,
                child: cartItems.isNotEmpty
                    ? CircleAvatar(
                        radius: 9,
                        backgroundColor: greenColour,
                        child: Text(
                          cartItems.length.toString(),
                          style: appBarCartStyle(),
                        ))
                    : const Text('')

               
                );
          }),
        ],
      ),
      constWidth10
    ],
  );
}

AppBar appBarSecondaryCommon({String? titleText, context}) {
  //  final cartProvider = Provider.of<CartProvider>(context, listen: false);

  return AppBar(
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
      titleText!,
      style: cardCurrencyTextStyle(),
    ),
  );
}
