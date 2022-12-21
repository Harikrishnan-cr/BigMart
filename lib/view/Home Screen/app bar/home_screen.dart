// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:big_mart/controller/cart%20provider/cart_provider.dart';
import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/firebase/auth_firebase.dart';
import 'package:big_mart/controller/const/size/size.dart';
import 'package:big_mart/controller/const/style/Home%20Text/home_text.dart';
import 'package:big_mart/controller/const/style/text_style.dart';
import 'package:big_mart/controller/users%20location%20provider/users_location_provider.dart';
import 'package:big_mart/view/Home%20Screen/home%20body/home_content.dart';
import 'package:big_mart/view/cart%20screen/cart_screen.dart';

import 'package:big_mart/view/common/slider/slider_screen.dart';
import 'package:big_mart/view/location%20screen/location_screen.dart';
import 'package:big_mart/view/login%20screen/login_screen.dart';
import 'package:big_mart/view/search_screen/search_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String? name;
String? userName;
bool _isLoading = false;

@override
class _HomeScreenState extends State<HomeScreen> {
  final User? userLogin = authInstance.currentUser;

  @override
  void initState() {
    getUserData();

    super.initState();
  }

  Future getUserData() async {
    // setState(() {
    //   _isLoading = true;
    // });
    if (userLogin == null) {
      setState(() {
        _isLoading = true;
      });
      return;
    }

    try {
      String uid = userLogin!.uid;
      final DocumentSnapshot userDetails = await FirebaseFirestore.instance
          .collection('usersdetails')
          .doc(uid)
          .get();

      if (userDetails == null) {
        return;
      } else {
        setState(() {
          name = userDetails.get('name');
          //email = userDetails.get('email');
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: mainAppBarHome(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            constHeight10,
            constHeight10,
            sliderScreens(),
            constHeight10,
            constHeight10,
            constHeight10,
            headText(headTitle: 'Flash Sales', context: context),
            constHeight10,
            const SizedBox(
                height: 250, child: HomeScreenContentOrderBYDiscount()),
            headText(headTitle: 'Recent', context: context),
            constHeight10,
            const SizedBox(height: 250, child: HomeScreenContentOrderBYDate()),
          ],
        ),
      ),
    ));
  }
}

AppBar mainAppBarHome(BuildContext context) {
  return AppBar(
    backgroundColor: appCanvasColour,
    title: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _isLoading
              ? Text(
                  'Hi Guset',
                  style: TextStyle(
                      color: blackColour,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )
              : Text(
                  'Hi,$name',
                  style: TextStyle(
                      color: blackColour,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
          _isLoading
              ? Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginUserScreen.namedRoute);
                      },
                      child: Text('Login ',
                          style: TextStyle(
                              color: secondGreenColour,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                    ),
                    Text('to continue shoping ',
                        style: TextStyle(
                            color: blackColour,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ],
                )
              : Row(
                  children: [
                    Text('Hi,$name ',
                        style: TextStyle(
                            color: secondGreenColour,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                    Text('Welcome to BigMart',
                        style: TextStyle(
                            color: blackColour,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
          constHeight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Consumer<UsersLocationProvider>(
                      builder: (context, usersLocationProvider, _) {
                    return GestureDetector(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return LocationScreen();
                          },
                        ));
                        //final data =  await usersLocationProvider.determinePosition().then((value) => usersLocationProvider.convertLocation(data: value));
                      },
                      child: Text(usersLocationProvider.location,
                          style: TextStyle(
                              color: blackColour,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    );
                  }),
                  Icon(
                    Icons.arrow_drop_down,
                    color: blackColour,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  log('Cart pressed');
                  Navigator.pushNamed(context, CartScreen.routName);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Stack(
                    children: [
                      Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: secondGreenColour,
                              borderRadius: BorderRadius.circular(12)),
                          child: Icon(
                            Icons.shopping_cart,
                            color: blackColour,
                          )),
                      Consumer<CartProvider>(
                          builder: (context, cartProvider, _) {
                        final cartItems =
                            cartProvider.getCartItems.values.toList();
                        return Positioned(
                            top: 1,
                            left: 22,
                            child: cartItems.isNotEmpty
                                ? CircleAvatar(
                                    radius: 9,
                                    backgroundColor: greenColour,
                                    child: Text(
                                      cartItems.length.toString(),
                                      style: appBarCartStyle(),
                                    ))
                                : Text(''));
                      }),
                    ],
                  ),
                ),
              )
            ],
          ),
          constHeight10,
          Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: blackColour, width: 1),
                  color: whiteColour,
                  borderRadius: BorderRadius.circular(22)),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return SearchScreen();
                      },
                    ));
                  },
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.,
                    children: [
                      constWidth10,
                      Icon(
                        Icons.search,
                        color: greyBacground,
                      ),
                      constWidth10,
                      Text(
                        'Type product name to search',
                        style: TextStyle(
                            color: greyBacground,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                  // TextField(
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     fillColor: whiteColour,
                  //     prefixIcon: const Icon(Icons.search),
                  //     border: const OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(20)),
                  //     ),
                  //     hintText: 'Type product name to search',
                  //   ),
                  // ),
                  )),
        ],
      ),
    ),
    toolbarHeight: 160,
    elevation: 0,
  );
}
