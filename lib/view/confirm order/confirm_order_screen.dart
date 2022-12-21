import 'package:big_mart/view/common/Bottom%20Bar/bottom_bar_screen.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    callHomeScreen(context);

    return Scaffold(
        body: ListView(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/payment tick.json'),
        SizedBox(
            width: 250,
            height: 250,
            child: Lottie.asset('assets/payment order.json', repeat: false)),
      ],
    ));
  }

  Future callHomeScreen(context) async {
    Future.delayed(Duration(seconds: 5))
        .whenComplete(() => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const BottomBarScreen(),
            ),
            (route) => false));
  }
}
