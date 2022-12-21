import 'dart:developer';

import 'package:big_mart/controller/cart%20provider/cart_provider.dart';
import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/size/size.dart';
import 'package:big_mart/controller/const/style/Home%20Text/card_text_style.dart';
import 'package:big_mart/controller/const/style/text_style.dart';
import 'package:big_mart/controller/product%20provider/product_provider.dart';
import 'package:big_mart/controller/review%20provider/review_provider.dart';
import 'package:big_mart/model/cart%20model/cart_model.dart';
import 'package:big_mart/model/user%20adress%20model/adressmode.dart';

import 'package:big_mart/view/common/App%20Bar/app_bar_common.dart';

import 'package:big_mart/view/login%20screen/login_screen.dart';
import 'package:big_mart/view/payment_screen/payment_card.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({Key? key, required this.adreesdetails}) : super(key: key);

  final UserAddressModel adreesdetails;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final productProvide = Provider.of<ProductProvider>(context);
    final reviewProvider = Provider.of<ReviewProvider>(context, listen: false);

    final cartItems =
        cartProvider.getCartItems.values.toList().reversed.toList();

    final double lengt;
    if (cartItems.length > 2) {
      lengt = (cartItems.length * 194.0) - (30 * cartItems.length);
    } else {
      lengt = cartItems.length * 191.0;
    }

    return Scaffold(
      appBar: appBarSecondaryCommon(titleText: 'Review', context: context),
      body: ListView(
        children: [
          ReviewAdressWidget(adreesdetails: adreesdetails),
          constHeight10,
          OrderSummaryList(
              lengt: lengt,
              cartItems: cartItems,
              productProvide: productProvide),
          ReviewTotalSubtotal(),
          GestureDetector(
            onTap: () {
              log(cartTotal.toString());

              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      color: appCanvasColour,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Payment Option',
                            style: cardTextStyle(),
                          ),

//---------------------------------------------------------------------------
                          Consumer<ReviewProvider>(
                              builder: (context, reviewProv, _) {
                            return GestureDetector(
                                onTap: () {
                                  reviewProv.changeValueRadio(0);
                                },
                                child: RadioButtonPaymentWidget(
                                  title: 'Online Payment',
                                  value: 0,
                                  changeValue: reviewProv.value,
                                ));
                          }),

                          Consumer<ReviewProvider>(
                              builder: (context, reviewProv, _) {
                            return GestureDetector(
                                onTap: () {
                                  reviewProv.changeValueRadio(1);
                                },
                                child: RadioButtonPaymentWidget(
                                  title: 'Cash On Delivery',
                                  value: 1,
                                  changeValue: reviewProv.value,
                                ));
                          }),

                          constHeight10,
                          constHeight10,

                          GestureDetector(
                            onTap: () {
                              log(reviewProvider.value.toString());
                            },
                            child: Consumer<ReviewProvider>(
                                builder: (context, reviewProvider, _) {
                              return ProceedToCheckOutScreen(
                                addressModel: adreesdetails,
                                totalPrice: cartTotal,
                                cartCount: cartItems.length,
                                paymentOption: reviewProvider.value,
                              );
                            }),
                          )

//---------------------------------------------------------------------------
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child:const CommonButtobMain( 
              height: 45,
              titleText: 'Select Payment Option',
            ),
          )
        ],
      ),
    );
  }
}

class ReviewTotalSubtotal extends StatelessWidget {
  const ReviewTotalSubtotal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
      child: Container(
        width: double.infinity,

        height: 90,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
          color: whiteColour,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 0.2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Item Subtotal',
                    style: reviewRsTextStyle(),
                  ),
                  Row(
                    children: [
                      Text(
                        '₹ ',
                        style: cardCurrencyTextStyle(),
                      ),
                      Text(
                        cartTotal.toStringAsFixed(2),
                        style: reviewRsTextStyle(),
                      ),
                    ],
                  )
                ],
              ),
              Divider(
                thickness: 0.5,
                color: blackColour,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount ',
                    style: cardRsTextStyle(),
                  ),
                  Row(
                    children: [
                      Text(
                        '₹ ',
                        style: cardCurrencyTextStyle(),
                      ),
                      Text(
                        cartTotal.toStringAsFixed(2),  
                        style: cardRsTextStyle(), 
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        // color: blackColour,
      ),
    );
  }
}

class OrderSummaryList extends StatelessWidget {
  const OrderSummaryList({
    Key? key,
    required this.lengt,
    required this.cartItems,
    required this.productProvide,
  }) : super(key: key);

  final double lengt;
  final List<CartModel> cartItems;
  final ProductProvider productProvide;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        width: double.infinity,
        height: lengt,
        decoration: BoxDecoration(
          // color: greenColour,
          color: whiteColour,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            constHeight10,
            Text(
              'Order Summary',
              style: userScreenTextStyle(),
            ),
            constHeight10,
            Expanded(
                child: Column(
              children: List.generate(cartItems.length, (index) {
                final getProducts = productProvide.findProductById(
                    productId: cartItems[index].productId);
                final cartdata = cartItems[index];
                // final data = cartItems[index];

                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: double.infinity,
                    // color: greenColour,
                    height: 140,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FancyShimmerImage(
                                imageUrl: getProducts.imgUrl,
                                width: 110,
                                height: 70,
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        // color: whiteColour,
                                        // color: greenColour,
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover)),
                                  );
                                },
                              ),
                              SizedBox(
                                  width: 180,
                                  height: 80,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      getProducts.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 15),
                                      maxLines: 2,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Quantity : ${cartdata.productQuantity}',
                                style: reviewRsTextStyle(),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '₹ ',
                                    style: cardCurrencyTextStyle(),
                                  ),
                                  Text(
                                    getProducts.price.toString(),
                                    style: markedTextStyle(),
                                  ),
                                  constWidth5,
                                  constWidth5,
                                  Text(
                                    '₹ ',
                                    style: cardCurrencyTextStyle(),
                                  ),
                                  Text(
                                    '${getProducts.discountPrice * cartdata.productQuantity}',
                                    style: reviewRsTextStyle(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Divider(
                          color: blackColour,
                          thickness: 0.6,
                        ),
                        //  Divider(thickness: 5,color: blackColour,),
                        // Text(getProducts.title),
                        // Text(adreesdetails.adressLineOne)
                      ],
                    ),
                  ),
                );
              }),
            )),
          ]),
        ),
      ),
    );
  }
}

// class RadioButtonPaymentWidget extends StatelessWidget {
//   const RadioButtonPaymentWidget({
//     Key? key,
//     required this.value,
//   }) : super(key: key);

//   final int value;
// final String title = 'Online Payment';
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class RadioButtonPaymentWidget extends StatelessWidget {
  const RadioButtonPaymentWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.changeValue,
  }) : super(key: key);

  final String title;
  final int value;
  final int changeValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
            color: whiteColour,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 0.0), //(x,y)
                blurRadius: 1.0,
              ),
            ],
            borderRadius: BorderRadius.circular(13)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: reviewRsTextStyle(),
              ),
              Radio(
                activeColor: greenColour,
                value: value,
                groupValue: changeValue,
                onChanged: (value) {
                  // reviewPro.changeValueRadio(value);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewAdressWidget extends StatelessWidget {
  const ReviewAdressWidget({
    Key? key,
    required this.adreesdetails,
  }) : super(key: key);

  final UserAddressModel adreesdetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 8),
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ], color: whiteColour, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Deliver To', style: cardTextStyle()),
              constHeight5,
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      adreesdetails.houseName,
                      style: reviewCardTextStyle(),
                    ),
                    constHeight5,
                    Text(
                      adreesdetails.adressLineOne,
                      style: reviewCardTextStyle(),
                    ),
                    constHeight5,
                    Text(
                      '${adreesdetails.adressLineTwo}, ${adreesdetails.pincode}',
                      style: reviewCardTextStyle(),
                    ),
                    constHeight5,
                    Text(
                      adreesdetails.phoneNumber.toString(),
                      style: reviewCardTextStyle(),
                    ),
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
