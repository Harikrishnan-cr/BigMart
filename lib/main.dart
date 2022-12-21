import 'package:big_mart/controller/adress%20provider/address_provider.dart';
import 'package:big_mart/controller/bottom_bar_controller/bottom_bar_provider.dart';
import 'package:big_mart/controller/cart%20provider/cart_provider.dart';
import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/favorite%20provider/favorite_provider.dart';
import 'package:big_mart/controller/orders%20provider/orders_provider.dart';
import 'package:big_mart/controller/product%20provider/product_provider.dart';
import 'package:big_mart/controller/review%20provider/review_provider.dart';
import 'package:big_mart/controller/search_provider/search_provider.dart';
import 'package:big_mart/controller/slider_proider/slider_Provider.dart';
import 'package:big_mart/controller/users%20location%20provider/users_location_provider.dart';
import 'package:big_mart/controller/validation_provider/validation_provider.dart';
import 'package:big_mart/load.dart';

import 'package:big_mart/view/cart%20screen/cart_screen.dart';
import 'package:big_mart/view/common/Bottom%20Bar/bottom_bar_screen.dart';
import 'package:big_mart/view/confirm%20order/confirm_order_screen.dart';
import 'package:big_mart/view/login%20screen/login_screen.dart';


import 'package:big_mart/view/signup%20screen/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  final Future<FirebaseApp> _fireBaseInitization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fireBaseInitization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: HomeLOadingScreen(),
            );
          } else if (snapshot.hasError) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: HomeMainScreen(),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => BottomBarProvider()),
              ChangeNotifierProvider(create: (_) => ProductProvider()),
              ChangeNotifierProvider(create: (_) => CartProvider()),
              ChangeNotifierProvider(create: (_) => FavoriteProider()),
              ChangeNotifierProvider(create: (_) => OrdersProvider()),
              ChangeNotifierProvider(create: (_) => AddressProvide()),
              ChangeNotifierProvider(create: (_) => ReviewProvider()),   
              ChangeNotifierProvider(create: (_) => SearchProvider()),      
              ChangeNotifierProvider(create: (_) => ValidationProvider()),       
              ChangeNotifierProvider(create: (_) => SliderProvider()),         
              ChangeNotifierProvider(create: (_) => UsersLocationProvider()),         
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  //  useMaterial3: true,
                  canvasColor: appCanvasColour),
         // home:   ConfirmOrderScreen(),  
           home: const LoadData(),
              // home:  const BottomBarScreen(),
              routes: {
                CartScreen.routName: (ctx) => CartScreen(),
                LoginUserScreen.namedRoute: (ctx) => LoginUserScreen(),
                SignUpUserScreen.namedRoute: (ctx) => SignUpUserScreen(),
                BottomBarScreen.namedRoute: (ctx) => BottomBarScreen(),
                
              },
            ),
          );
        });
  }
}

class HomeLOadingScreen extends StatelessWidget {
  const HomeLOadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: greenColour,
        ),
      ),
    );
  }
}

class HomeMainScreen extends StatelessWidget {
  const HomeMainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColour,
      body: const Center(
        child: Text('has error'),
      ),
    );
  }
}
