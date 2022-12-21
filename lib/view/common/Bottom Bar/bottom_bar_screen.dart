// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:big_mart/controller/adress%20provider/address_provider.dart';
import 'package:big_mart/controller/bottom_bar_controller/bottom_bar_provider.dart';
import 'package:big_mart/controller/cart%20provider/cart_provider.dart';
import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/firebase/auth_firebase.dart';
import 'package:big_mart/controller/favorite%20provider/favorite_provider.dart';
import 'package:big_mart/controller/orders%20provider/orders_provider.dart';

import 'package:big_mart/view/Home%20Screen/app%20bar/home_screen.dart';

import 'package:big_mart/view/categories/categories_screen.dart';
import 'package:big_mart/view/common/catagory%20details/category_details.dart';
import 'package:big_mart/view/likes%20screen/liked_screen.dart';
import 'package:big_mart/view/user%20profile/user_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class BottomBarScreen extends StatelessWidget {
  static const namedRoute = "/BottomBarScreen";
  const BottomBarScreen({Key? key}) : super(key: key);

  static const List<Widget> _widgetOptions = [
    HomeScreen(),
    //CatagoryDetailsScreen(),
    LikedScreen(),
    CategoriesScreen(),
    UserProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final User? userTile = authInstance.currentUser;
    if (userTile == null) {
      log('no user');
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final favoriteProvider =
          Provider.of<FavoriteProider>(context, listen: false);
      final ordersProvider =
          Provider.of<OrdersProvider>(context, listen: false);
      final addressProvide =
          Provider.of<AddressProvide>(context, listen: false);
      cartProvider.fetchGusestUserCartItems();
      favoriteProvider.fetchGuestUserWishListItems();
      ordersProvider.fetchGuestUserOrderListDeatils();
      addressProvide.fetchGusestUserAddressDetails();
    }

    final bottomProvider =
        Provider.of<BottomBarProvider>(context, listen: false);
    log('rebuild app');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<BottomBarProvider>(builder: (context, data, _) {
        log('rebuild ui');
        return Center(
          child: _widgetOptions.elementAt(data.selectedIndex),
        );
      }),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: appCanvasColour,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
            child: GNav(
              rippleColor: greenColour,
              hoverColor: greenColour,
              gap: 6,

              activeColor: blackColour,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              //147804
              tabBackgroundColor: greenColour,
              color: blackColour,
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'Likes',
                ),
                GButton(
                  icon: LineIcons.microsoft,
                  text: 'Categories',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: bottomProvider.selectedIndex,
              onTabChange: (index) {
                bottomProvider.bottomBarChanged(index: index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
