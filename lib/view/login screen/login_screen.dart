import 'dart:developer';

import 'package:big_mart/controller/adress%20provider/address_provider.dart';
import 'package:big_mart/controller/cart%20provider/cart_provider.dart';
import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/firebase/auth_firebase.dart';
import 'package:big_mart/controller/const/size/size.dart';
import 'package:big_mart/controller/const/style/Home%20Text/card_text_style.dart';
import 'package:big_mart/controller/const/style/text_style.dart';
import 'package:big_mart/controller/favorite%20provider/favorite_provider.dart';
import 'package:big_mart/controller/orders%20provider/orders_provider.dart';
import 'package:big_mart/controller/slider_proider/slider_Provider.dart';
import 'package:big_mart/controller/validation_provider/validation_provider.dart';

import 'package:big_mart/view/common/Bottom%20Bar/bottom_bar_screen.dart';
import 'package:big_mart/view/signup%20screen/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginUserScreen extends StatelessWidget {
  static const namedRoute = "/LoginUserScreen";
  LoginUserScreen({Key? key}) : super(key: key);

  final String mainemail = 'EMAIL';
  final String labelEmail = 'Email';
  final double height = 45;

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  void clearFieldFunction() {
    _emailTextController.clear();
    _passwordTextController.clear();
  }

  Future onSignUpButtonPressed(
      {context,
      required CartProvider cartProvider,
      required FavoriteProider favoriteProvider,
      required OrdersProvider ordersProvider,
      required AddressProvide addressProvide}) async {
    try {
      await authInstance.signInWithEmailAndPassword(
          email: _emailTextController.text.toLowerCase().trim(),
          password: _passwordTextController.text.trim());
      Navigator.of(context).pushNamedAndRemoveUntil(
          BottomBarScreen.namedRoute, (route) => false);
      //Navigator.of(context).pushReplacementNamed(BottomBarScreen.namedRoute);
      clearFieldFunction();
      await cartProvider.fetchUserCartItems();
      await favoriteProvider.fetchUserWishListItems();
      await ordersProvider.fetchOrderListDeatils();
      await addressProvide.fetchUserAdressDeatils();
    } on FirebaseException catch (error) {
      log(error.toString());
      final snackBar = SnackBar(
        content: Text(error.message.toString()),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      log('${e.toString()} -----------------');
    }
  }

  @override
  Widget build(BuildContext context) {
    log('login----------');
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final favoriteProvider =
        Provider.of<FavoriteProider>(context, listen: false);
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    final addressProvide = Provider.of<AddressProvide>(context, listen: false);
    final sliderProvider = Provider.of<SliderProvider>(context, listen: false);
     sliderProvider.fetchSliderImageList(); 

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    constHeight10,
                    constHeight10,
                    constHeight10,
                    constHeight10,
                    Text(
                      'WELCOME BACK!',
                      style: productRsTextStyle(),
                    ),
                    constHeight5,
                    Text(
                      'Sign in to Continue',
                      style: loginUserScreenSecondaryCardTextStyle(),
                    ),
                  ],
                ),
              ),
              constHeight10,
              constHeight10,
              constHeight10,
              Consumer<ValidationProvider>(
                  builder: (context, validationProvider, _) {
                log('login consumer');
                return Column(
                  children: [
                    EmailLoginPageControllers(
                      onChanged: (value) {
                        validationProvider.userEmailChanges(value);
                      },
                      error: validationProvider.userEmail.error,
                      textInputType: TextInputType.emailAddress,
                      mainemail: mainemail,
                      labelEmail: labelEmail,
                      textController: _emailTextController,
                    ),
                    constHeight5,
                    EmailLoginPageControllers(
                      onChanged: (value) {
                        validationProvider.userPassWordChanges(value);
                      },
                      error: validationProvider.userPassword.error,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: true,
                      mainemail: 'PASSWORD',
                      labelEmail: 'Password',
                      textController: _passwordTextController,
                    ),
                  ],
                );
              }),
              Consumer<ValidationProvider>(
                  builder: (context, validationProvider, _) {
                return Column(
                  children: [
                    GestureDetector(
                        onTap: () async {
                          await onSignUpButtonPressed(
                              context: context,
                              addressProvide: addressProvide,
                              cartProvider: cartProvider,
                              ordersProvider: ordersProvider,
                              favoriteProvider: favoriteProvider);

                          // _emailTextController.clear();
                          // _passwordTextController.clear();
                        },
                        child: validationProvider.isPasswordValid == true &&
                                validationProvider.isEmailValidc == true
                            ? CommonButtobMain(height: height)
                            : GestureDetector(
                                onTap: () {},
                                child: CommonButtobMain(
                                  height: height,
                                  colours: Colors.green,
                                ))),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.symmetric(horizontal: 60, vertical: 5),
                    //   child: Container(
                    //     width: double.infinity,
                    //     height: 40,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(1),
                    //         image: const DecorationImage(
                    //             image: NetworkImage(
                    //               'https://d172mw7nx82lso.cloudfront.net/assets/landing/auth/google-d33f9eb20af60f124ea3de0def9116700064e558db8a63275354162d46ae09cb.png',
                    //             ),
                    //             fit: BoxFit.fill),
                    //         color: greenColour),
                    //   ),
                    // ),
                    Text(
                      'or',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                          color: blackColour),
                    ),
                    GestureDetector(
                        onTap: () async {
                          Navigator.of(context)
                              .pushReplacementNamed(BottomBarScreen.namedRoute);

                          // Navigator.of(context)
                          //     .pushReplacementNamed(BottomBarScreen.namedRoute);
                        },
                        child: CommonButtobMain(
                          height: height,
                          colours: blackColour,
                          titleText: 'Continue as a guest',
                        )),
                  ],
                );
              }),
              constHeight5,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have an account?',
                    style: cardTextStyle(),
                  ),
                  constWidth5,
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(SignUpUserScreen.namedRoute);
                      },
                      child: Text(
                        'Sign up',
                        style: userLoginTextStyle(),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CommonButtobMain extends StatelessWidget {
  const CommonButtobMain(
      {Key? key, required this.height, this.titleText, this.colours})
      : super(key: key);

  final double height;
  final Color? colours;
  final String? titleText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
            color: colours ?? greenColour,
            borderRadius: BorderRadius.circular(12)),
        child: Center(
            child: Text(
          titleText ?? 'SIGN IN',
          style: addTextStyle(),
        )),
      ),
    );
  }
}

class EmailLoginPageControllers extends StatelessWidget {
  const EmailLoginPageControllers(
      {Key? key,
      required this.mainemail,
      required this.labelEmail,
      required this.textController,
      this.error,
      required this.textInputType,
      this.onChanged,
      this.obscureText})
      : super(key: key);
  final bool? obscureText;
  final String mainemail;
  final String labelEmail;
  final TextInputType textInputType;
  final TextEditingController textController;
  final void Function(String)? onChanged;
  final String? error;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mainemail,
            style: cardRsTextStyle(),
          ),
          TextField(
              onChanged: onChanged,
              keyboardType: textInputType,
              autocorrect: true,
              obscureText: obscureText == null ? false : true,
              controller: textController,
              decoration: InputDecoration(
                  errorText: error,
                  labelText: labelEmail,
                  labelStyle: loginUserScreenSecondaryCardTextStyle())),
        ],
      ),
    );
  }
}
