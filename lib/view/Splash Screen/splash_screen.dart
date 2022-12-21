import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/firebase/auth_firebase.dart';

import 'package:big_mart/view/common/Bottom%20Bar/bottom_bar_screen.dart';

import 'package:big_mart/view/login%20screen/login_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? userLogin = authInstance.currentUser;
    // final productsProvider =
    //     Provider.of<ProductProvider>(context, listen: false);
    // productsProvider.fetchProducts();
    //log(productsProvider.getProductList[0].title.toString() ?? 'novalue');
    return AnimatedSplashScreen(
      backgroundColor: greenColour,
      splash: Text(
        'BigMart',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: whiteColour, fontSize: 35),
      ),
      nextScreen: userLogin == null ? LoginUserScreen() : BottomBarScreen(),
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}

// class SpalshSample extends StatelessWidget {
//   const SpalshSample({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
// body: Container(
//   color: greenColour,
//   width: double.infinity,
//   height: double.infinity,
//   child: Center(child: Text('Big-Mart',style: TextStyle(fontWeight: FontWeight.bold,color: whiteColour,fontSize: 35 ),)),
// ),
//     );
//   }
// }

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: greenColour,
//       body: Center(
//         child: Text('BigMart',style: TextStyle(fontWeight: FontWeight.bold,color: whiteColour,fontSize: 35 )),
//       ),
//     );
//   }
// }
