import 'dart:developer';

import 'package:big_mart/controller/cart%20provider/cart_provider.dart';
import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/style/Home%20Text/card_text_style.dart';

import 'package:big_mart/controller/product%20provider/product_provider.dart';
import 'package:big_mart/view/cart%20screen/cart%20widget/cart_widget.dart';

import 'package:big_mart/view/common/cart%20bottom%20bar/cart_bottom_bar.dart';
import 'package:big_mart/view/product%20details/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routName = "/CartScreen";
  CartScreen({Key? key}) : super(key: key);

  num totalPrice = 0.0;
  @override
  Widget build(BuildContext context) {
    log('ssssssssssssss');
    final cartprovider = Provider.of<CartProvider>(context);
    final productProvide = Provider.of<ProductProvider>(context);
    return cartprovider.getCartItems.isNotEmpty
        ? Scaffold(
            appBar: cartAppBar(context),
            body: Consumer<CartProvider>(builder: (context, cartProvider, _) {
              totalPrice = 0.0;
              final cartItems =
                  cartProvider.getCartItems.values.toList().reversed.toList();

              return Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: ListView(
                  children: List.generate(cartItems.length, (index) {
                    log(cartItems[index].productQuantity.toString());
                    final getProducts = productProvide.findProductById(
                        productId: cartItems[index].productId);

                    totalPrice += getProducts.discountPrice *
                        cartItems[index].productQuantity;

                    log('-------------------- $totalPrice -------------------');
               
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailsScreen(products: getProducts),
                        ));
                      },
                      child: CartScreenCard(
                        cartModel: cartItems[index],
                      ),
                    );
                  }),
                ),
              );
            }),
            bottomSheet:
                Consumer<CartProvider>(builder: (context, cartProvider, _) {
              final cartItems = cartProvider.getCartItems.length;

              //  log('${cartItems.toString()}  ssssssbbbbbbbssss');
              return cartItems != 0
                  ? CartScreenBottomBar(
                      cartCount: cartItems,
                      totalPrice: totalPrice,
                    )
                  : Container();
            }))
        : Scaffold(
            appBar: cartAppBar(context),
            body: Center(
              child: Lottie.asset(
                  'assets/cart.json'), 
            ),
          );
  }
}

AppBar cartAppBar(context) {
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
      'Your Cart',
      style: cardCurrencyTextStyle(),
    ),
  );
}
