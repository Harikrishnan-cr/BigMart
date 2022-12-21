import 'dart:developer';

import 'package:big_mart/controller/adress%20provider/address_provider.dart';
import 'package:big_mart/controller/cart%20provider/cart_provider.dart';
import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/favorite%20provider/favorite_provider.dart';
import 'package:big_mart/controller/orders%20provider/orders_provider.dart';
import 'package:big_mart/controller/product%20provider/product_provider.dart';
import 'package:big_mart/controller/slider_proider/slider_Provider.dart';
import 'package:big_mart/controller/users%20location%20provider/users_location_provider.dart';
import 'package:big_mart/view/Splash%20Screen/splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class LoadData extends StatefulWidget {
   
  const LoadData({Key? key}) : super(key: key);

  @override
  State<LoadData> createState() => _LoadDataState();
}

class _LoadDataState extends State<LoadData> {
  @override
  Widget build(BuildContext context) {
    getDetails();
    getUserCartDetails();
    return Scaffold(
      backgroundColor: greenColour,
      body: Center(
        child: CircularProgressIndicator(
          color: whiteColour,
          strokeWidth: 5,
        ),
      ),
    );
  }

  void getUserCartDetails() async {

    
    
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final favoriteProvider = Provider.of<FavoriteProider>(context, listen: false);
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    final addressProvide = Provider.of<AddressProvide>(context, listen: false);
    final sliderProvider = Provider.of<SliderProvider>(context, listen: false);
    final usersLocationProvider = Provider.of<UsersLocationProvider>(context, listen: false);

    await cartProvider.fetchUserCartItems();
    await favoriteProvider.fetchUserWishListItems();
    await ordersProvider.fetchOrderListDeatils(); 
    await addressProvide.fetchUserAdressDeatils();
    await sliderProvider.fetchSliderImageList();  
   usersLocationProvider.determinePosition().then((value) => usersLocationProvider.convertLocation(data: value));  


log(usersLocationProvider.location); 
        
  }

  void getDetails() async {  
    final productsProvider =
        Provider.of<ProductProvider>(context, listen: false);
await productsProvider.fetchProductsOnTheBasisOfDiscount(); 
    productsProvider.fetchProducts().then((value) async {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return const SplashScreen();
        },
      ));
    });
  }
}



