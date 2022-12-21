import 'dart:developer';

import 'package:big_mart/controller/cart%20provider/cart_provider.dart';
import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/firebase/auth_firebase.dart';
import 'package:big_mart/controller/const/style/text_style.dart';
import 'package:big_mart/controller/product%20provider/product_provider.dart';
import 'package:big_mart/model/user%20adress%20model/adressmode.dart';

import 'package:big_mart/view/cart%20screen/checkout%20screen/checkout_screen.dart';
import 'package:big_mart/view/confirm%20order/confirm_order_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartScreenBottomBar extends StatelessWidget {
  const CartScreenBottomBar({Key? key, this.cartCount, this.totalPrice})
      : super(key: key);
  final int? cartCount;
  final num? totalPrice;

  @override
  Widget build(BuildContext context) {
    // final cartprovider = Provider.of<CartProvider>(context, listen: false);
    // final productsProvider =
    //     Provider.of<ProductProvider>(context, listen: false);
    // var price;
// log('bottom called');
// setState(() {

// });
// final cartprovidercontroller = Provider.of<CartProvider>(context,listen: false);
    cartTotalAssign(totalPrice);
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
      width: double.infinity,
      height: 43,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: greenColour,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$cartCount items | ₹ ${totalPrice!.toStringAsFixed(2)}',
              style: addTextStyle(),
            ),
            GestureDetector(
                onTap: () {
                  log('On Tap');

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return CheckOutScreen();
                    },
                  ));
                },
                // onTap: () {
                //   log('Proced to checkout');
                //   User? userId = authInstance.currentUser;

                //   cartprovider.getCartItems.forEach((key, value) async {
                //     final orderId = const Uuid().v4();
                //     log(value.productQuantity.toString());
                //     final items = productsProvider.findProductById(
                //         productId: value.productId);

                //     try {
                //       await FirebaseFirestore.instance
                //           .collection('orders')
                //           .doc(orderId)
                //           .set({
                //         'orderId': orderId,
                //         'userId': userId!.uid,
                //         'productId': value.productId,
                //         'imgUrl': items.imgUrl,
                //         'userName': 'Hari',
                //         'price': items.discountPrice,
                //         'status': 'orderd',
                //         'productName':items.title,
                //         'totalPrice': totalPrice,
                //         'noOfProducts': cartCount,
                //         'productQuantity': value.productQuantity,
                //         'orderDate': DateTime.now()
                //       });
                //     } catch (e) {
                //       log(e.toString());
                //     }

                //     cartprovider.clearMyCart();
                //   });
                // },
                child: Text(
                  ' Proceed to CheckOut',
                  style: addTextStyle(),
                )),
          ],
        ),
      ),
    );
  }
}


