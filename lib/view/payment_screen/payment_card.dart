import 'dart:developer';

import 'package:big_mart/controller/cart%20provider/cart_provider.dart';
import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/firebase/auth_firebase.dart';
import 'package:big_mart/controller/const/style/text_style.dart';
import 'package:big_mart/controller/product%20provider/product_provider.dart';
import 'package:big_mart/model/user%20adress%20model/adressmode.dart';
import 'package:big_mart/view/confirm%20order/confirm_order_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';

class ProceedToCheckOutScreen extends StatefulWidget {
  const ProceedToCheckOutScreen(
      {Key? key,
      this.cartCount,
      this.totalPrice,
      required this.paymentOption,
      required this.addressModel})
      : super(key: key);
  final int? cartCount;
  final num? totalPrice;
  final int paymentOption;
  final UserAddressModel addressModel;

  @override
  State<ProceedToCheckOutScreen> createState() =>
      _ProceedToCheckOutScreenState();
}

class _ProceedToCheckOutScreenState extends State<ProceedToCheckOutScreen> {


  late CartProvider cartprovider;
  late ProductProvider productsProvider;

  @override
  Widget build(BuildContext context) {
    cartprovider = Provider.of<CartProvider>(context, listen: false);
    productsProvider = Provider.of<ProductProvider>(context, listen: false);

    cartTotalAssign(widget.totalPrice);
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
              '${widget.cartCount} items | ₹ ${widget.totalPrice!.toStringAsFixed(2)}', 
              style: addTextStyle(),
            ),
            GestureDetector(
                onTap: () async {
                  log('On Tap');

                  if (widget.paymentOption == 0) {
                    User? userId = authInstance.currentUser;
                    final DocumentSnapshot userDetails = await FirebaseFirestore
                        .instance
                        .collection('usersdetails')
                        .doc(userId!.uid)
                        .get();

                    // final userName = userDetails.get('name');
                    final userEmail = userDetails.get('email');
                    final userPhone = userDetails.get('phone-number');

                    Razorpay razorpay = Razorpay();
                    var options = {
                      'key': 'rzp_test_k6JqhQvUIpY75P',
                      'amount': widget.totalPrice! * 100,
                      'name': 'BigMart',
                      'description': 'Fine T-Shirt',
                      'retry': {'enabled': true, 'max_count': 100000},
                      'send_sms_hash': true,
                      'prefill': {'contact': userPhone, 'email': userEmail},
                      'external': {
                        'wallets': ['paytm']
                      }
                    };
                    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                        handlePaymentErrorResponse);
                    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                        handlePaymentSuccessResponse);
                    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                        handleExternalWalletSelected);
                    razorpay.open(options);
                  } else if (widget.paymentOption == 1) {
                    log('Cash on Delevary');
                    await placeOrderdresCashOnDelivary(
                        cartprovider, productsProvider);
                    log('Proced to checkout');
                  } else {
                    log('----------------------');
                  }

               
                },
               
                child: Text(
                  ' Proceed to CheckOut',
                  style: addTextStyle(),
                )),
          ],
        ),
      ),
    );
  }

  Future placeOrderdresCashOnDelivary(cartprovider, productsProvider) async {
    User? userId = authInstance.currentUser;
    final DocumentSnapshot userDetails = await FirebaseFirestore.instance
        .collection('usersdetails')
        .doc(userId!.uid)
        .get();

    final userName = userDetails.get('name');
    log(userName);

    cartprovider.getCartItems.forEach((key, value) async {
      final orderId = const Uuid().v4();
      log(value.productQuantity.toString());
      final items =
          productsProvider.findProductById(productId: value.productId);

      try {
        await FirebaseFirestore.instance.collection('orders').doc(orderId).set({
          'orderId': orderId,
          'payment-type': 'cod',
          // 'paymentId':'',
          // 'signature':'',
          // 'ordersIdPaynent':'',
          'userId': userId.uid,
          'productId': value.productId,
          'imgUrl': items.imgUrl,
          'userName': userName,
          'houseName': widget.addressModel.houseName,
          'addressOne': widget.addressModel.adressLineOne,
          'addressTwo': widget.addressModel.adressLineTwo,
          'pinCode': widget.addressModel.pincode,
          'userPhone': widget.addressModel.phoneNumber,
          'price': items.discountPrice,
          'status': 'orderd',
          'productName': items.title,
          'totalPrice': widget.totalPrice,
          'noOfProducts': widget.cartCount,
          'productQuantity': value.productQuantity,
          'orderDate': DateTime.now()
        });
      } catch (e) {
        log(e.toString());
      }

      cartprovider.clearMyCart();
    });

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ConfirmOrderScreen();
      },
    ));
  }

  Future placeOrderdresOnlinePayment(cartprovider, productsProvider) async {}

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    log('error');
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    //showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    log('successs');
    response.orderId;
    response.paymentId;
    response.signature;

    log(response.signature.toString());

    User? userId = authInstance.currentUser;
    final DocumentSnapshot userDetails = await FirebaseFirestore.instance
        .collection('usersdetails')
        .doc(userId!.uid)
        .get();

    final userName = userDetails.get('name');
    log(userName);

    cartprovider.getCartItems.forEach((key, value) async {
      final orderId = const Uuid().v4();
      log(value.productQuantity.toString());
      final items =
          productsProvider.findProductById(productId: value.productId);

      try {
        await FirebaseFirestore.instance.collection('orders').doc(orderId).set({
          'orderId': orderId,
          'userId': userId.uid,
          'payment-type': 'onp',
          'paymentId': response.paymentId,
          'productId': value.productId,
          'imgUrl': items.imgUrl,
          'userName': userName,
          'houseName': widget.addressModel.houseName,
          'addressOne': widget.addressModel.adressLineOne,
          'addressTwo': widget.addressModel.adressLineTwo,
          'pinCode': widget.addressModel.pincode,
          'userPhone': widget.addressModel.phoneNumber,
          'price': items.discountPrice,
          'status': 'orderd',
          'productName': items.title,
          'totalPrice': widget.totalPrice,
          'noOfProducts': widget.cartCount,
          'productQuantity': value.productQuantity,
          'orderDate': DateTime.now()
        });
      } catch (e) {
        log(e.toString());
      }

      cartprovider.clearMyCart();
    });

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ConfirmOrderScreen();
      },
    ));
    //placeOrderdresCommon(cartprovider, productsProvider);
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    // showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    // showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }

  // void showAlertDialog(BuildContext context, String title, String message){
  //   // set up the buttons
  //   Widget continueButton = ElevatedButton(
  //     child: const Text("Continue"),
  //     onPressed:  () {},
  //   );
  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text(title),
  //     content: Text(message),
  //     actions: [
  //       continueButton,
  //     ],
  //   );
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
}
